extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

var board = null
var pices = Array()

func _ready():
	board = preload("res://Board.tscn").instantiate()
	_add_Pice("res://img/Twick.png", Vector2(155, 45))
	add_child(board)
	board.position = Vector2(120, 10)
	
func _on_HSlider_value_changed(value):
	board._loadBoard(value)
	for pice in pices:
		pice.scale = Vector2(value, value)

func _on_Button3_pressed():
	var file_dialog = FileDialog.new()
	file_dialog.access = 2
	file_dialog.connect("file_selected", Callable(self, "set_Image_Background"))
	file_dialog.current_dir = OS.get_system_dir(6)
	file_dialog.mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.filters = ["*.png", "*.jpg"]
	
	add_child(file_dialog)
	file_dialog.popup_centered()


func _on_Button2_pressed():
	var file_dialog = FileDialog.new()
	file_dialog.access = 2
	file_dialog.connect("file_selected", Callable(self, "_add_Pice"))
	file_dialog.current_dir = OS.get_system_dir(6)
	file_dialog.mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.filters = ["*.png", "*.jpg"]
	add_child(file_dialog)
	file_dialog.popup_centered()

func _add_Pice(path, pice_position = Vector2(-10, 10)):
	var tile  = load("res://Tile.tscn").instantiate()
	add_child(tile)
	pices.append(tile)
	tile.priority = pices.size()
	tile.scale = Vector2(board.cell_scale, board.cell_scale)
	tile.position = pice_position
	tile.z_index = 10
	tile._set_image(path)
	tile.connect("input_event", Callable(get_node("Camera2D"), "_on_Tile_Event"))

func set_Image_Background(path):
	board.set_Image_Background(path)
	
	$CanvasLayer/Panel/VBoxContainer/OptionButton.clear()
	for scale in board.valid_scales:
		$CanvasLayer/Panel/VBoxContainer/OptionButton.add_item(str(scale))
	

func _on_option_button_item_selected(index):
	var value = float($CanvasLayer/Panel/VBoxContainer/OptionButton.get_item_text(index))
	board._loadBoard(value)
	for pice in pices:
		pice.scale = Vector2(value, value)


func _on_host_pressed():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	
	
func _add_player(id = 1):
	print("connected player")

func _on_join_pressed():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer

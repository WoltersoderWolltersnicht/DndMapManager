extends Sprite

var with = texture.get_width()
var heigth = texture.get_height()
var x_actual_cell_with = null

var x_actual_cells = null

func _ready():
	_loadBoard(0.78)
	pass # Replace with function body.

func delete_children():
	var children = get_children()
	for child in children:
		remove_child(child)

func _loadBoard(cell_scale:float):	
	delete_children()
	var cell_length = 64 * cell_scale

	var x_cells = with / cell_length
	var y_cells = heigth / cell_length
	
	for y_cell in y_cells -1:
		for x_cell in x_cells -1:
			var cell = load("res://Cell.tscn").instance()
			add_child(cell)
			var x = x_cell * cell_length 
			var y = y_cell * cell_length
			cell.scale = Vector2(cell_scale, cell_scale)
			cell.position = (Vector2(x, y))

func root(n, s) -> float:
	return pow(n, (1.0/s))

func _on_FileDialog_files_selected(paths):
	var img = Image.new()
	var itex = ImageTexture.new()
	img.load(paths)
	itex.create_from_image(img)
	texture = itex


func _on_Button3_pressed():
	var file_dialog = FileDialog.new()
	file_dialog.access = 2
	file_dialog.connect("file_selected", self, "_on_FileDialog_files_selected")
	file_dialog.current_dir = OS.get_system_dir(6)
	file_dialog.mode = FileDialog.MODE_OPEN_FILE
	file_dialog.filters = ["*.png", "*.jpg"]
	file_dialog.resizable = true
	
	add_child(file_dialog)
	file_dialog.popup_centered()

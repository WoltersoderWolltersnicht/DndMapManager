extends Node2D


export var zoom_speed = 0.5
export var min_scale = 0.5
export var max_scale = 2.0

var initial_distance = 0.0
var initial_scale = Vector2(1, 1)

var board = null

func _ready():
	var boardScreen = preload("res://Board.tscn").instance()
	add_child(boardScreen)
	boardScreen.position = Vector2(120, 10)
	board = boardScreen.get_node("Board")

func _process(delta):
	if Input.is_key_pressed(KEY_PLUS):
		zoom_in()
	elif Input.is_key_pressed(KEY_MINUS):
		zoom_out()

func _input(event):	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom_in()
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoom_out()
	
	if event is InputEventScreenTouch:
		if event.is_pressed():
			handle_touch(event)
		else:
			initial_distance = 0.0

func zoom_in():
	scale *= (1.0 + zoom_speed)

func zoom_out():
	scale /= (1.0 + zoom_speed)
	
func handle_touch(event):
	if event.get_touch_count() == 2:
		var touch1 = event.get_touch(0)
		var touch2 = event.get_touch(1)
		var distance = touch1.position.distance_to(touch2.position)

		if initial_distance == 0.0:
			initial_distance = distance
			initial_scale = scale
			return

		var pinch_scale = initial_scale * (distance / initial_distance)
		pinch_scale.x = clamp(pinch_scale.x, min_scale, max_scale)
		pinch_scale.y = clamp(pinch_scale.y, min_scale, max_scale)
		scale = pinch_scale


func _on_HSlider_value_changed(value):
	board._loadBoard(value)
	pass # Replace with function body.

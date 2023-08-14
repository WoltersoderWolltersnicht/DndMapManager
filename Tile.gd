extends Area2D

var grid_size = 128.0
var selected = false

func _on_DragableTile_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true
		
		
func _physics_process(delta):
	if selected: 
		var mouse_position = get_global_mouse_position()
		global_position = lerp(global_position, mouse_position, 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false

func _set_image(path):
	var img = Image.new()
	img.load(path)
	$Sprite2D.texture = ImageTexture.create_from_image(img)

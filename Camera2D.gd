extends Camera2D

var is_tile_selected = false

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			if is_tile_selected == false:
				position -= event.relative * zoom

func _on_Tile_Event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_tile_selected = event.pressed
			


extends Sprite2D

var with = float(texture.get_width())
var heigth = float(texture.get_height())
var cell_scale = 1
var valid_scales = Array()

func _ready():
	_loadBoard(1)
	pass # Replace with function body.

func _loadBoard(cell_scale:float):	
	self.cell_scale = cell_scale
	delete_children()
	var cell_length = 64 * cell_scale

	var x_cells = with / cell_length
	var y_cells = heigth / cell_length
	
	for y_cell in y_cells -1:
		for x_cell in x_cells -1:
			var cell = load("res://Cell.tscn").instantiate()
			add_child(cell)
			var x = x_cell * cell_length 
			var y = y_cell * cell_length
			cell.scale = Vector2(cell_scale, cell_scale)
			cell.position = (Vector2(x, y))

func delete_children():
	var children = get_children()
	for child in children:
		remove_child(child)

func set_Image_Background(paths):
	var img = Image.new()
	img.load(paths)
	texture = ImageTexture.create_from_image(img)
	
	with = float(texture.get_width())
	heigth = float(texture.get_height())
	_calculateValidPossitions()
	_loadBoard(1)

func _calculateValidPossitions():
	valid_scales = Array()
	var check_scale = 0.780
	
	while check_scale < 5:
		var cell_length = 64 * check_scale
		
		var x_quotient = int(with / cell_length)
		var x_remainder = int(with - (cell_length * x_quotient))
		if(x_remainder == 0):
			var y_quotient = int(heigth / cell_length)
			var y_remainder = int(heigth - (cell_length * y_quotient))
			if(y_remainder == 0):
				valid_scales.append(check_scale)
		
		check_scale += 0.001 

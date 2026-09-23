extends Node2D

@export var tile_scene: PackedScene

var unit_pixels = 64
var map_layers: Dictionary = {}

var grid_width = 10
var grid_height = 10

var current_rotation: int = 0

var viewport_size 
var map_offset 
var tile_scene_wall
	


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_Q:
			# Incrementa la rotazione da 0 a 3
			current_rotation = (current_rotation + 1) % 4
		elif event.keycode == KEY_E:
			# Decrementa la rotazione gestendo il negativo in modo sicuro
			current_rotation = (current_rotation - 1 + 4) % 4
		else:
			return # Se non è né Q né E, esce subito senza ricalcolare inutilmente
					
		match current_rotation:
			0:
				rotate_map(down_or_x, down_or_y)
			1:
				rotate_map(left_or_x, left_or_y)
			2:
				rotate_map(up_or_x, up_or_y)
			3:
				rotate_map(right_or_x, right_or_y)


func _ready() -> void:
	y_sort_enabled = true
	tile_scene = AssetLoader._get_resource("battle screen","battle_tile.tscn", "tscn")
	tile_scene_wall = AssetLoader._get_resource("battle screen","battle_tile_wall.tscn", "tscn")
	
	generate_grid()

func generate_grid() -> void:
	
	viewport_size = get_viewport().get_visible_rect().size
	map_offset = Vector2(viewport_size.x / 2, 10)
	


	for y in range(10):
		for x in range(10):
			var tile: BattleTile = tile_scene.instantiate()
			tile.position = linear_transform(x,y, down_or_x, down_or_y) + map_offset
			tile.grid_x = x 
			tile.grid_y = y 
			_handle_elevation(tile, x, y)
	

func _handle_elevation(tile: BattleTile, grid_x, grid_y):
	var random_height = randi_range(1, 4)
	var base_position = tile.position
	
	if random_height == 0:
		tile.position = base_position
		tile.z_index = 0
		add_child(tile)
	else:
	
		tile.position = base_position + Vector2(0, random_height * -32)
		tile.z_index = random_height
		add_child(tile)
		

		for h in range(random_height):
			var wall_block: BattleTile = tile_scene_wall.instantiate()
			
			var current_height_index = random_height - 1 - h
			var y_height = (h + 1) * 32
			
			wall_block.position = base_position + Vector2(0, y_height - (random_height * 32))
			wall_block.grid_x = grid_x
			wall_block.grid_y = grid_y
			wall_block.z_index = current_height_index
			add_child(wall_block)

			
func linear_transform(x_coordinate,y_coordinate, x_ori, y_ori):
	var x_pixels = x_coordinate * unit_pixels
	var y_pixels = y_coordinate * unit_pixels
	var x_linear_transformation = x_ori /2
	var y_linear_transformation = y_ori /2
	var new_x = x_pixels * x_linear_transformation 
	var new_y = y_pixels * y_linear_transformation
	var base_pos = new_x + new_y

	return base_pos
	
	
func rotate_map(orientation_x, orientation_y):
	for child in get_children():
		# Filtriamo solo i nodi che sono tile (puoi usare un gruppo o il nome della classe)
		if child is BattleTile: # Oppure: if child is BattleTile:
			child.position = linear_transform(child.grid_x, child.grid_y, orientation_x, orientation_y) + map_offset


func _on_rotate_map():
	rotate_map(left_or_x, left_or_y)

var left_or_x = Vector2(-1,0.5)
var left_or_y = Vector2( -1,-0.5)
var up_or_x =  Vector2( -1,-0.5)
var up_or_y = Vector2(1,-0.5)
var right_or_x = Vector2(1,-0.5)
var right_or_y = Vector2(1, 0.5)
var down_or_x = Vector2(1,0.5)
var down_or_y = Vector2(-1,0.5)













#----------------testing----------------------

#@export var grid_widths: int = 4
#@export var grid_heights: int = 4
#@export var cell_size: int = 32
#@export var grid_color: Color = Color(1, 0, 0, 0.5) # Rosso semitrasparente
#var tile_color: Color = Color(1.0, 0.3, 0.3, 0.8)   # Rosso corallo
#var tile_color2: Color = Color(0.3, 1.0, 0.3, 0.8)  # Verde acceso
#var tile_color3: Color = Color(0.3, 0.6, 1.0, 0.8)  # Blu azzurro
#var tile_color4: Color = Color(1.0, 0.8, 0.2, 0.8)  # Giallo dorato


#func _draw() -> void:
## Partiamo esattamente dall'origine locale (0,0) del nodo
	#draw_set_transform(Vector2.ZERO, 0, Vector2(1, 1))
	#
	##0,1 = 0,64
	##1,0 = 64,0 griglia normale
#
##
	### I 4 vertici del rombo isometrico nello spazio schermo:
	##var P_left = linear_transform(0,0) + Vector2(64,0)     # Corrisponde a (0, 0) logico
	##var p_bottom = linear_transform(64,0)  + Vector2(64,0)         # Corrisponde a (1, 0) logico
	##var p_right = linear_transform(64, 64) + Vector2(64,0)  # Corrisponde a (1, 1) logico (LA SOMMA!)
	##var p_top = linear_transform(0, 64)  + Vector2(64,0)     # Corrisponde a (0, 1) logico
##
	### Chiudiamo il rombo disegnando i 4 lati
	##draw_line(P_left, p_bottom, tile_color, 2.0)
	##draw_line(p_bottom, p_right, tile_color2, 2.0)
	##draw_line(p_right, p_top, tile_color3, 2.0)
	##draw_line(p_top, P_left, tile_color4, 2.0)
	##
	##
	##var P_left2: Vector2 = linear_transform(0,0) + Vector2((64*3),64)     # Corrisponde a (0, 0) logico
	##var p_bottom2: Vector2 = linear_transform(64,0)  + Vector2((64*3),64)         # Corrisponde a (1, 0) logico
	##var p_right2: Vector2 = linear_transform(64, 64) + Vector2((64*3),64)  # Corrisponde a (1, 1) logico (LA SOMMA!)
	##var p_top2: Vector2 = linear_transform(0, 64)  + Vector2((64*3),64)     # Corrisponde a (0, 1) logico
##
	### Chiudiamo il rombo disegnando i 4 lati
	##draw_line(P_left2, p_bottom2, tile_color, 2.0)
	##draw_line(p_bottom2, p_right2, tile_color2, 2.0)
	##draw_line(p_right2, p_top2, tile_color3, 2.0)
	##draw_line(p_top2, P_left2, tile_color4, 2.0)
		#
	## Disegna le linee verticali della griglia logica
	#for x in range(grid_widths + 1):
		#var start = Vector2(x * cell_size, 0)
		#var end = Vector2(x * cell_size, grid_heights * cell_size)
		#draw_line(start, end, grid_color, 2.0)
		#
	## Disegna le linee orizzontali della griglia logica
	#for y in range(grid_heights + 1):
		#var start = Vector2(0, y * cell_size)
		#var end = Vector2(grid_widths * cell_size, y * cell_size)
		#draw_line(start, end, grid_color, 2.0)
#
#func _process(_delta: float) -> void:
	#queue_redraw()

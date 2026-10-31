extends Node2D

var tile_scene: PackedScene
var tile_scene_wall: PackedScene
var tile_water: PackedScene
var tile_medium_water: PackedScene
var tiler_river: PackedScene



var unit_pixels = 64
var map_layers: Dictionary[int, Array] = {}

var grid_width = 20
var grid_height = 20

var current_rotation: int = 0

var viewport_size 
var map_offset 

var noise = FastNoiseLite.new()

func _draw_a_river():
	var x = 0
	var y = 0

	if randi() % 2 == 0:
		# L'asse X è bloccata a 0, la Y è casuale lungo il bordo sinistro
		x = 0
		y = randi_range(0, grid_height -1)
	else:
		# L'asse Y è bloccata a 0, la X è casuale lungo il bordo superiore
		x = randi_range(0, grid_width -1 )
		y = 0

	var punto_partenza = Vector2i(x, y)
	
	var punto_arrivo = Vector2i((grid_width -1) - punto_partenza.x, (grid_height -1) - punto_partenza.y)
	
	var x_grow = 0
	var y_grow = 0
	if (punto_partenza.x != punto_arrivo.x):
		x_grow = 1 if punto_partenza.x < punto_arrivo.x else -1
	if (punto_partenza.y != punto_arrivo.y):
		y_grow = 1 if punto_partenza.y < punto_arrivo.y else -1
	print(x_grow)
	print(y_grow)
	var new_pos_x = punto_partenza.x
	var new_pos_y = punto_partenza.y
	var distanza_x = abs(punto_partenza.x - punto_arrivo.x)
	var distanza_y = abs(punto_partenza.y - punto_arrivo.y)
	var total_steps = distanza_x + distanza_y

	var diagonal_steps:float = min(distanza_x, distanza_y)
	var straight_steps:float = total_steps - (diagonal_steps * 2)

	print("partenza: " + str(punto_partenza))
	print("arrivo: " + str(punto_arrivo))
	print ("STEP TOTALI " + str(total_steps))
	print("diagonale: " + str(diagonal_steps))
	print("straight: " + str(straight_steps))

	var new_position
	var current_pos = punto_partenza
	while current_pos != punto_arrivo:
		# Scegli se fare una diagonale (se ce ne sono ancora disponibili)
		# oppure se fare un passo dritto
		var can_do_diagonal = diagonal_steps > 0
		var can_do_straight = straight_steps > 0
		
		# Decide casualmente solo se entrambe le opzioni sono ancora disponibili
		var do_diagonal = false
		if can_do_diagonal and can_do_straight:
			do_diagonal = (randi() % 2 == 0)
		elif can_do_diagonal:
			do_diagonal = true

		if do_diagonal:
			# Muovi su entrambi gli assi (1 passo X + 1 passo Y)
			current_pos.x += x_grow
			current_pos.y += y_grow
			diagonal_steps -= 1
			total_steps -= 2  # Consuma 2 passi dal totale!
		else:
			# Muovi solo sull'asse che ha ancora distanza da coprire
			if (current_pos.x != punto_arrivo.x) and (distanza_x > distanza_y or current_pos.y == punto_arrivo.y):
				current_pos.x += x_grow
			else:
				current_pos.y += y_grow
				
			straight_steps -= 1
			total_steps -= 1
			
		print(current_pos)




func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_Q:
			current_rotation = (current_rotation + 1) % 4
		elif event.keycode == KEY_E:
			current_rotation = (current_rotation - 1 + 4) % 4
		else:
			return 
					
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
	_draw_a_river()


	y_sort_enabled = true
	tile_scene = AssetLoader._get_resource("plains","grass_tile.tscn", "tscn")
	tile_scene_wall = AssetLoader._get_resource("plains","grass_tile_wall.tscn", "tscn")
	tile_water = AssetLoader._get_resource("plains", "water_tile.tscn", "tscn")
	tile_medium_water = AssetLoader._get_resource("plains", "water_tile_medium.tscn", "tscn")
	tiler_river = AssetLoader._get_resource("plains", "water_tile_river.tscn", "tscn")
	
	# --- CONFIGURAZIONE FASTNOISELITE (Elevazione) ---
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.08 
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.seed = randi()
	
	map_layers = {}
	generate_grid()

func generate_grid() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	map_offset = Vector2(viewport_size.x / 2, 10)

	for y in range(grid_height):
		for x in range(grid_width):
			_handle_tile_generation(x, y)

	for layer in map_layers.values():
		for tile: BattleTile in layer:
			add_child(tile)

func _handle_tile_generation(grid_x: int, grid_y: int) -> void:
	# 1. Calcolo l'elevazione con il primo rumore
	var raw_noise = noise.get_noise_2d(grid_x, grid_y)
	var normalized_noise = (raw_noise + 1.0) / 2.5
	
	var random_height = 1
	if normalized_noise > .90:
		random_height = 5
	elif normalized_noise > 0.75:
		random_height = 4
	elif normalized_noise > 0.55:
		random_height = 3
	elif normalized_noise > 0.35:
		random_height = 2
	else:
		random_height = 1

	var current_tile_scene = tile_scene

	var tile: BattleTile = current_tile_scene.instantiate()
	var base_position = linear_transform(grid_x, grid_y, down_or_x, down_or_y) + map_offset
	
	tile.position = base_position
	tile.grid_x = grid_x 
	tile.grid_y = grid_y 

	_handle_elevation(tile, base_position, random_height, grid_x, grid_y)

func _handle_elevation(tile: BattleTile, base_position: Vector2, random_height: int, grid_x: int, grid_y: int):
	for layer in range(random_height + 1):
		if not map_layers.has(layer):
			map_layers[layer] = []
	
	if random_height == 0:
		tile.position = base_position
		tile.height = 0
		tile.z_index = 0
		map_layers[random_height].append(tile)
	else:
		tile.position = base_position + Vector2(0, random_height * -32)
		tile.height = random_height
		tile.z_index = random_height
		map_layers[random_height].append(tile)
		
		for h in range(random_height):
			var wall_block: BattleTile = tile_scene_wall.instantiate()
			
			var current_height_index = random_height - 1 - h
			var y_height = (h + 1) * 32
			wall_block.position = base_position + Vector2(0, y_height - (random_height * 32))
			wall_block.grid_x = grid_x
			wall_block.grid_y = grid_y
			wall_block.z_index = current_height_index
			wall_block.height = tile.height - (h+1)
			map_layers[tile.height - (h+1)].append(wall_block)
			
func linear_transform(x_coordinate, y_coordinate, x_ori, y_ori, h=0):
	var x_pixels = x_coordinate * unit_pixels
	var y_pixels = y_coordinate * unit_pixels
	var x_linear_transformation = x_ori /2
	var y_linear_transformation = y_ori /2
	var new_x = x_pixels * x_linear_transformation 
	var new_y = y_pixels * y_linear_transformation
		
	var base_pos = new_x + new_y
	if (h != 0):
		base_pos = base_pos + Vector2(0, -1 * (h * 32))
	return base_pos
	
func rotate_map(orientation_x, orientation_y):
	for array in map_layers.values():
		for tile: BattleTile in array:
			tile.position = linear_transform(tile.grid_x, tile.grid_y, orientation_x, orientation_y, tile.height) + map_offset

const left_or_x = Vector2(-1,0.5)
const left_or_y = Vector2( -1,-0.5)
const up_or_x =  Vector2( -1,-0.5)
const up_or_y = Vector2(1,-0.5)
const right_or_x = Vector2(1,-0.5)
const right_or_y = Vector2(1, 0.5)
const down_or_x = Vector2(1,0.5)
const down_or_y = Vector2(-1,0.5)

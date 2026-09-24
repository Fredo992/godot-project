extends Node2D

@export var tile_scene: PackedScene

var unit_pixels = 64
var map_layers: Dictionary[int, Array] = {}

var grid_width = 10
var grid_height = 10

var current_rotation: int = 0

var viewport_size 
var map_offset 
var tile_scene_wall

# --- AGGIUNTA 1: Variabile per il rumore ---
var noise = FastNoiseLite.new()
	
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
	y_sort_enabled = true
	tile_scene = AssetLoader._get_resource("battle screen","battle_tile.tscn", "tscn")
	tile_scene_wall = AssetLoader._get_resource("battle screen","battle_tile_wall.tscn", "tscn")
	
	# --- AGGIUNTA 2: Configurazione del FastNoiseLite ---
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.08 # Più è basso, più le colline sono larghe
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.seed = randi()
	
	map_layers = {}
	generate_grid()

func generate_grid() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	map_offset = Vector2(viewport_size.x / 2, 10)

	for y in range(20):
		for x in range(20):
			var tile: BattleTile = tile_scene.instantiate()
			tile.position = linear_transform(x,y, down_or_x, down_or_y) + map_offset
			tile.grid_x = x 
			tile.grid_y = y 
			_handle_elevation(tile, x, y)

	for layer in map_layers.values():
		for tile in layer:
			add_child(tile)

func _handle_elevation(tile: BattleTile, grid_x, grid_y):
	# --- MODIFICA: Sostituito randi_range con il Noise campionato su x e y ---
	var raw_noise = noise.get_noise_2d(grid_x, grid_y) # Restituisce tra -1.0 e 1.0
	var normalized_noise = (raw_noise + 1.0) / 2.0 # Lo portiamo tra 0.0 e 1.0
	
	# Mappiamo il valore decimale in un'altezza discreta da 1 a 4
	var random_height = 1
	if normalized_noise >.90:
		random_height = 5
	elif normalized_noise > 0.75:
		random_height = 4
	elif normalized_noise > 0.55:
		random_height = 3
	elif normalized_noise > 0.35:
		random_height = 2
	else:
		random_height = 1
	# ----------------------------------------------------------------------

	var base_position = tile.position
	
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
			
func linear_transform(x_coordinate,y_coordinate, x_ori, y_ori, h=0):
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
			tile.position = linear_transform(tile.grid_x, tile.grid_y, orientation_x, orientation_y, tile.height)

const left_or_x = Vector2(-1,0.5)
const left_or_y = Vector2( -1,-0.5)
const up_or_x =  Vector2( -1,-0.5)
const up_or_y = Vector2(1,-0.5)
const right_or_x = Vector2(1,-0.5)
const right_or_y = Vector2(1, 0.5)
const down_or_x = Vector2(1,0.5)
const down_or_y = Vector2(-1,0.5)

extends Node2D

# Carichiamo la scena del tassello che hai appena creato
@export var tile_scene: PackedScene

# Dimensioni della griglia (quante caselle vuoi in larghezza e altezza)
@export var grid_width: int = 4
@export var grid_height: int = 4

@export var tile_width: int = 64
@export var tile_height: int = 32

# Un offset opzionale per centrare la mappa a schermo (es. spostarla più in basso)
@export var map_offset_x: int = 320
@export var map_offset_y: int = 180

func _ready() -> void:
	tile_scene = AssetLoader._get_resource("battle screen","battle_tile.tscn", "tscn")
	generate_grid()

func generate_grid() -> void:
	var screen_width = get_viewport().get_visible_rect().size.x
	print(screen_width)
	print(screen_width / 64)
	var number_of_tiles = screen_width / tile_width

	var vector_offset = Vector2(map_offset_x, map_offset_y)
	var vector_tile = Vector2(tile_width, tile_height)

	var tile = tile_scene.instantiate()
	var tile2 = tile_scene.instantiate()
	var tile3 = tile_scene.instantiate()
	var tile4 = tile_scene.instantiate()
	var tile5 = tile_scene.instantiate()
	var tile6 = tile_scene.instantiate()
	var tile7 = tile_scene.instantiate()
	var tile8 = tile_scene.instantiate()
	var tile9 = tile_scene.instantiate()
	
	tile.position = linear_transform(0,0) + vector_offset
	add_child(tile)
	tile2.position = linear_transform(32,32) + vector_offset
	add_child(tile2)
	tile3.position = linear_transform(-32,32) + vector_offset
	add_child(tile3)
	tile4.position = linear_transform(0,32) + vector_offset
	add_child(tile4)
	tile5.position = linear_transform(0,-32) + vector_offset
	add_child(tile5)
	tile6.position = linear_transform(-32,0) + vector_offset
	add_child(tile6)
	tile7.position = linear_transform(-32,-32) + vector_offset
	add_child(tile7)
	tile8.position = linear_transform(32,0) + vector_offset
	add_child(tile8)
	tile9.position = linear_transform(32,-32) + vector_offset
	add_child(tile9)

func linear_transform(x,y):
	var x_linear_transformation = Vector2(1,0.5)
	var y_linear_transformation = Vector2(-1, 0.5)
	var new_x = x * x_linear_transformation
	var new_y = y * y_linear_transformation
	print(new_y)
	return new_x + new_y
	
		

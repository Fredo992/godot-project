extends Node2D

# Carichiamo la scena del tassello che hai appena creato
@export var tile_scene: PackedScene

var unit_pixels = 64

# Dimensioni della griglia (quante caselle vuoi in larghezza e altezza)
@export var grid_width: int = 4
@export var grid_height: int = 4

# Un offset opzionale per centrare la mappa a schermo (es. spostarla più in basso)
@export var map_offset_x: int = 0
@export var map_offset_y: int = 0
var screen_width
var screen_height


func _ready() -> void:
	tile_scene = AssetLoader._get_resource("battle screen","battle_tile.tscn", "tscn")
	generate_grid()

func generate_grid() -> void:
	
	var viewport_size = get_viewport().get_visible_rect().size
	var map_offset = Vector2(viewport_size.x / 2, 10)
	print(screen_width)
	print(screen_height)
	
	
	var tile_number = 20
	for y in range(tile_number):
		for x in range(tile_number):
			var tile = tile_scene.instantiate()
			tile.position = linear_transform(x,y) + map_offset
			print("iteration number " + str(x) + " for vector " + str(tile.position))
			add_child(tile)


@export var grid_widths: int = 4
@export var grid_heights: int = 4
@export var cell_size: int = 32
@export var grid_color: Color = Color(1, 0, 0, 0.5) # Rosso semitrasparente
var tile_color: Color = Color(1.0, 0.3, 0.3, 0.8)   # Rosso corallo
var tile_color2: Color = Color(0.3, 1.0, 0.3, 0.8)  # Verde acceso
var tile_color3: Color = Color(0.3, 0.6, 1.0, 0.8)  # Blu azzurro
var tile_color4: Color = Color(1.0, 0.8, 0.2, 0.8)  # Giallo dorato

# gizmo for testing
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

func linear_transform(x_coordinate,y_coordinate):
	var x_pixels = x_coordinate * unit_pixels
	var y_pixels = y_coordinate * unit_pixels
	var x_linear_transformation = Vector2(1, 0.5) /2
	var y_linear_transformation = Vector2(-1, 0.5) /2
	var new_x = x_pixels * x_linear_transformation 
	var new_y = y_pixels * y_linear_transformation
	var base_pos = new_x + new_y

	return base_pos
	
	

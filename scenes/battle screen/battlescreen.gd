extends Node2D

# Carichiamo la scena del tassello che hai appena creato
@export var tile_scene: PackedScene

# Dimensioni della griglia (quante caselle vuoi in larghezza e altezza)
@export var grid_width: int = 10
@export var grid_height: int = 10

# Dimensioni del tuo tassello (basate sul tuo disegno 64x32)
@export var tile_width: int = 32
@export var tile_height: int = 16

# Un offset opzionale per centrare la mappa a schermo (es. spostarla più in basso)
@export var map_offset_x: int = 320
@export var map_offset_y: int = 180

func _ready() -> void:
	tile_scene = AssetLoader._get_resource("battle screen","battle_tile.tscn", "tscn")
	generate_grid()

func generate_grid() -> void:
	for x in range(grid_width):
		for y in range(grid_height):
			# 1. Istanziamo la scena del tile
			var tile = tile_scene.instantiate()
			
			# 2. Calcoliamo la posizione isometrica con la formula classica
			# X screen = (GridX - GridY) * (TileWidth / 2)
			# Y screen = (GridX + GridY) * (TileHeight / 2)
			var screen_x = (x - y) * (tile_width / 2)
			var screen_y = (x + y) * (tile_height / 2)
			
			# Applichiamo l'offset per non farlo partire dall'angolo esatto (0,0) dello schermo
			tile.position = Vector2(screen_x + map_offset_x, screen_y + map_offset_y)
			
			# 3. Assegniamo le coordinate logiche se il tuo Tile.gd le prevede
			if tile.has_method("set_grid_coordinates"):
				tile.set_grid_coordinates(x, y)
			
			# 4. Aggiungiamo il tile come figlio del nodo BattleMap
			add_child(tile)

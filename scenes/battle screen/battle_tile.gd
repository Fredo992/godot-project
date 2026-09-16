
extends Node2D

# Proprietà logiche del tassello
var grid_x: int = 0
var grid_y: int = 0
var is_walkable: bool = true

# Funzione per impostare le coordinate (chiamata dal generatore della mappa)
func set_grid_coordinates(x: int, y: int) -> void:
	grid_x = x
	grid_y = y
	# Se vuoi usare il nome del nodo per debuggarlo nella scena:
	name = "Tile_%d_%d" % [x, y]

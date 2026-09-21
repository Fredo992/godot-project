
extends Node2D

@onready var area: Area2D = $Area2D
@onready var collision_node = $Area2D/CollisionPolygon2D
@onready var sprite: Sprite2D = $Sprite2D

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


func _ready() -> void:
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_click() -> void:
	print("hai cliccato " + str(self.position))

func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

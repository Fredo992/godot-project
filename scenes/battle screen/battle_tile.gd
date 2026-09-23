
extends Node2D
class_name BattleTile

@onready var area: Area2D = $Area2D
@onready var collision_node = $Area2D/CollisionPolygon2D
@onready var sprite: Sprite2D = $Sprite2D


# Proprietà logiche del tassello
var grid_x: int = 0
var grid_y: int = 0
var is_walkable: bool = true

func _on_area_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_mouse_click()


func _ready() -> void:
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	area.input_event.connect(_on_area_input_event)

func _on_mouse_click() -> void:
	print("hai cliccato " + str(self.grid_x) + " " + str(self.grid_y))

func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

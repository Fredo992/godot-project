class_name MapObject
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D
@onready var collision_node = $Area2D/CollisionShape2D

var option_menu: Dictionary = {}

signal request_menu_open(option_menu: Dictionary)

func _on_area_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_mouse_click()

func _ready() -> void:
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	area.input_event.connect(_on_area_input_event)
	_setup()

func _setup() -> void:
	print("no children has been declared for this node!")
	
func _on_mouse_click() -> void:
	request_menu_open.emit(option_menu)

func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

func _setup_options_menu(options: Dictionary[String, Callable]):
	option_menu = options

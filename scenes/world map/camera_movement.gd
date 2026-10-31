extends Camera2D


@export var map_node: Node2D 

@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.2
@export var max_zoom: float = 3.0
@export var rotation_step: float = 90.0 

var is_dragging: bool = false

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			is_dragging = event.pressed
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
			
		zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

	if event is InputEventMouseMotion and is_dragging:
		position -= event.relative / zoom

extends Camera2D

# Trascini il nodo principale della mappa qui dentro dall'Ispettore di Godot, 
# oppure lo cerca in automatico
@export var map_node: Node2D 

@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.2
@export var max_zoom: float = 3.0
@export var rotation_step: float = 90.0 # I 90 gradi alla Final Fantasy Tactics

var is_dragging: bool = false

func _unhandled_input(event: InputEvent) -> void:
	# --- ZOOM E TRASCINAMENTO (rimangono sulla camera) ---
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

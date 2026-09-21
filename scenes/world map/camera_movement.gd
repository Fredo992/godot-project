extends Camera2D

@export var zoom_speed: float = 0.1  # Velocità di zoom a ogni scatto
@export var min_zoom: float = 0.2    # Zoom massimo (allontanato)
@export var max_zoom: float = 3.0    # Zoom minimo (avvicinato)

var is_dragging: bool = false

func _unhandled_input(event: InputEvent) -> void:
	
	# --- 1. TRASCINAMENTO CON LA ROTELLA PREMUTA ---
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed:
				is_dragging = true
			else:
				is_dragging = false
				
		# --- 2. ZOOM CON LA ROTELLA (Su / Giù) ---
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# Aumenta lo zoom (si avvicina)
			zoom += Vector2(zoom_speed, zoom_speed)
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Diminuisce lo zoom (si allontana)
			zoom -= Vector2(zoom_speed, zoom_speed)
			
		# Blocca i limiti di zoom per evitare che si capovolga o diventi microscopica
		zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

	# --- 3. MOVIMENTO MOUSE (Trascina e sposta) ---
	# Nota: se usi lo zoom, il movimento del mouse va diviso per lo zoom attuale 
	# altrimenti trascinando ti muoverai a velocità diverse a seconda di quanto sei zoomato.
	if event is InputEventMouseMotion and is_dragging:
		position -= event.relative / zoom

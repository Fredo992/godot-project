extends Camera2D

@export var scroll_speed: float = 50.0  # Di quanti pixel si muove a ogni scatto di rotella
var is_dragging: bool = false

func _unhandled_input(event: InputEvent) -> void:
	
	# --- 1. TRASCINAMENTO CON LA ROTELLA PREMUTA ---
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed:
				is_dragging = true
			else:
				is_dragging = false
				
		# --- 2. SCROLL CON LA ROTELLA (Su / Giù) ---
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			# GIRI VERSO L'ALTO -> la mappa scende, la visuale sale
			position.y -= scroll_speed
			
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# GIRI VERSO IL BASSO -> la mappa sale, la visuale scende
			position.y += scroll_speed

	# --- 3. MOVIMENTO MOUSE (Trascina e sposta) ---
	if event is InputEventMouseMotion and is_dragging:
		position -= event.relative

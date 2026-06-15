extends Camera2D

# Velocità di scorrimento della telecamera
@export var velocita_scroll: float = 20.0

func _ready() -> void:
	# Limiti Orizzontali nativi di Godot
	limit_left = 0
	limit_right = 640
	
	# Limiti Verticali nativi di Godot (i tuoi valori)
	limit_bottom = 1040   # Fondo della mappa
	limit_top = 0         # Cima della mappa

func _unhandled_input(event):
	# Se il giocatore gira la rotellina del mouse in sù (va verso l'alto, Y diminuisce)
	if event.is_action_pressed("mouse_scroll_up"):
		position.y -= velocita_scroll
		
	# Se il giocatore gira la rotellina del mouse in giù (va verso il basso, Y aumenta)
	if event.is_action_pressed("mouse_scroll_down"):
		position.y += velocita_scroll

	position.y = clampf(position.y, 0.0 , 1040.0)

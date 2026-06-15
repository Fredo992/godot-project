
class_name MapObject
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D
const MENU_TENDINA_SCENE = preload("res://classes/ui/menu/popup_menu.tscn")
var option_menu: Dictionary = {}
var menu_istanza = null
var menu_scena = load("res://classes/ui/menu/popup_menu.tscn")
@onready var collision_node = $Area2D/CollisionShape2D
func _ready() -> void:
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	area.input_event.connect(_on_area_input_event)
	_setup()

func _setup() -> void:
	print("no children has been declared for this node!")
	
func _on_mouse_click() -> void:
	print("ho cliccato")
	if menu_istanza != null and menu_istanza.visible:
		if (menu_istanza.visible):
			menu_istanza.visible = false
		elif (!menu_istanza.visible):
			menu_istanza.visible = true
	else:
		menu_istanza = menu_scena.instantiate() 
		get_tree().root.add_child(menu_istanza)
		menu_istanza.global_position = get_global_mouse_position()
	
	
	

# --- Grafica e Hover (Valido per tutti i nodi) ---
func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

func _input(event: InputEvent) -> void:
	# Questo controlla i click FUORI dall'area
	if event.is_action_pressed("click"):
		# Se il menu esiste ed è aperto...
		if menu_istanza != null and menu_istanza.visible:
			# ...e il mouse NON è sopra l'oggetto in questo momento
		
			# TRUCCO SEMPLICE: Controlliamo se il mouse è lontano dall'oggetto
			var distanza = global_position.distance_to(get_global_mouse_position())
			var maxDistance = collision_node.shape.size.x / 2
			if distanza > maxDistance: # Cambia 64 in base a quanto è grande la tua sprite
				menu_istanza.visible = false
				print("Cliccato fuori! Chiudo il menu.")

func _on_area_input_event(node, event: InputEvent, int) -> void:
	if (event.is_action_pressed("click")):
		_on_mouse_click()

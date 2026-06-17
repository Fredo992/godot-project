
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
		menu_istanza._on_instance(test_options)
		get_tree().root.add_child(menu_istanza)
		menu_istanza.global_position = get_global_mouse_position()
		
	
	
	

# --- Grafica e Hover (Valido per tutti i nodi) ---
func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if menu_istanza != null and menu_istanza.visible:
			
			var mouse_pos = get_global_mouse_position()
			var mouse_distance_from_node = global_position.distance_to(mouse_pos)
			var maxDistance = collision_node.shape.size.x / 2
			var menu_rect: Rect2 = menu_istanza.get_node("SfondoMenu").get_global_rect()
			if mouse_distance_from_node > maxDistance && !menu_rect.has_point(mouse_pos): # Cambia 64 in base a quanto è grande la tua sprite
				menu_istanza.visible = false
				print("Cliccato fuori! Chiudo il menu.")

func _on_area_input_event(node, event: InputEvent, int) -> void:
	if (event.is_action_pressed("click")):
		_on_mouse_click()

func _setup_options_menu():
	return 
	
var test_options: Dictionary[String, Callable] = {
	"entra": func(): print("sono entrato"),
	"combatti AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA": func(): print("stai combattendo entrato"),
	"esci": func(): print("sono uscito"),
	
	
	
}

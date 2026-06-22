
class_name MapObject
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D
@onready var collision_node = $Area2D/CollisionShape2D
var menu_scena = load("res://classes/ui/menu/popup_menu.tscn")

var option_menu: Dictionary = {}
var menu_istanza = null
var mappa_rect = null




func sub(context) -> void:
	if context is InputEventMouseButton and context.pressed and context.button_index == MOUSE_BUTTON_LEFT:

		if mappa_rect and mappa_rect.open_menu != null and mappa_rect.open_menu.visible:
			# Se c'è già un menu aperto, non fare nulla e blocca l'esecuzione qui
			return
		
		
		var dimensione = collision_node.shape.size * global_scale
		var area_rect = Rect2(global_position - (dimensione / 2), dimensione)
		var mouse_pos = context.global_position
		if area_rect.has_point(mouse_pos):
			_on_mouse_click()
			mappa_rect.open_menu = menu_istanza
			mappa_rect.menu_shape = menu_istanza.get_node("SfondoMenu").get_global_rect()

func _ready() -> void:
	mappa_rect = get_tree().get_first_node_in_group("world_map") as TextureRect
	if (mappa_rect == null):
		print("errore mappa non caricata")
		return
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	_setup()
	InputManager.subscribe_click_ui(sub)

func _setup() -> void:
	print("no children has been declared for this node!")
	
func _on_mouse_click() -> void:
	if menu_istanza != null:
		if (!menu_istanza.visible):
			menu_istanza.visible = true
	else:
		print("sto istanziando menu istanza")
		menu_istanza = menu_scena.instantiate() 
		menu_istanza._on_instance(option_menu)
		add_child(menu_istanza)
		menu_istanza.position = Vector2.ZERO # Oppure Vector2(50, 0) per spostarlo un po'


		
	
	


# --- Grafica e Hover (Valido per tutti i nodi) ---
func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

func _setup_options_menu(options: Dictionary[String, Callable]):
	option_menu = options
	
	

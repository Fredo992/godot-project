
class_name MapObject
extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

var option_menu: Dictionary = {}
var menu_istanza = null
var menu_scena = load("res://classes/ui/menu/popup_menu.tscn")
@onready var collision_node = $Area2D/CollisionShape2D

func sub(context):
	if context is InputEventMouseButton and context.pressed and context.button_index == MOUSE_BUTTON_LEFT:
		
		# Chiediamo direttamente all'Area2D se il mouse globale è dentro il suo perimetro fisico
		if area.has_overlapping_areas() or area.get_overlapping_bodies() or Input.is_action_just_pressed("ui_accept") or true:
			
			# Questo metodo nativo di Godot calcola la collisione esatta nel mondo di gioco
			# tenendo conto di telecamera, offset, scale e posizioni sulla mappa.
			var query = PhysicsPointQueryParameters2D.new()
			query.position = context.global_position
			query.collide_with_areas = true
			
			var hits = get_world_2d().direct_space_state.intersect_point(query)
			
			for hit in hits:
				if hit.collider == area:
					
					_on_mouse_click()
					if get_viewport():
						get_viewport().set_input_as_handled()
					return
					
					
func _ready() -> void:
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	_setup()
	InputManager.subscribe_click_ui(sub)

func _setup() -> void:
	print("no children has been declared for this node!")
	
func _on_mouse_click() -> void:
	if menu_istanza != null:
		if (menu_istanza.visible):
			menu_istanza.visible = false
		elif (!menu_istanza.visible):
			menu_istanza.visible = true
	else:
		
		menu_istanza = menu_scena.instantiate() 
		menu_istanza._on_instance(option_menu)
		get_tree().root.add_child(menu_istanza)
		menu_istanza.global_position = get_global_mouse_position()

		
	
	


# --- Grafica e Hover (Valido per tutti i nodi) ---
func _on_mouse_entered() -> void:
	sprite.scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	sprite.scale = Vector2(1.0, 1.0)

func _setup_options_menu(options: Dictionary[String, Callable]):
	option_menu = options
	
	

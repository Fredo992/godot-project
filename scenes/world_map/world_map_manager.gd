extends Control


var visible_rows = 5
var open_menu: MyPopupMenu
var menu_shape: Rect2


func _ready() -> void:
	# 1. Se la cache è vuota, la generiamo e la salviamo nel GameManager
	if GameManager.map_cache.is_empty():
		var screen_heigth = get_viewport().get_visible_rect().size.y
		var screen_width = get_viewport().get_visible_rect().size.x
		var total_map_height = screen_heigth * visible_rows
		var map_generator = MapGenerator.new(total_map_height, screen_width)
		GameManager.save_map_cache(map_generator._generate_map())

	# 2. QUESTO DEVE STARE FUORI DALL'IF! 
	# Aggiunge i nodi alla scena sia che siano nuovi, sia che siano salvati.
	for node: MapObject in GameManager.map_cache:
		# Evitiamo di ricollegare il segnale se è già connesso
		if not node.request_menu_open.is_connected(_on_menu_requested):
			node.request_menu_open.connect(_on_menu_requested)
		
		# Se il nodo non ha un genitore, lo attacchiamo alla WorldMap
		if node.get_parent() == null:
			node.z_index = 1
			add_child(node)


func _on_menu_requested(option_menu) -> void:
	
	var menu_type = AssetLoader.get_resource("menu", "popup_menu.tscn", "tscn") as PackedScene
	open_menu = menu_type.instantiate() as MyPopupMenu

	add_child(open_menu)

	open_menu.position = get_local_mouse_position()
	open_menu._on_instance(option_menu)

	menu_shape = open_menu.menu_rect

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if open_menu:
			var mouse_pos = get_local_mouse_position()
			if not menu_shape.has_point(mouse_pos):
				open_menu.queue_free()
				open_menu = null
				
func _on_button_pressed_roaster():
	for node in GameManager.map_cache:
		if node.get_parent():
			node.get_parent().remove_child(node) 
	GameManager.change_scene(AssetLoader.get_file("inventory", "roaster.tscn", "tscn"))

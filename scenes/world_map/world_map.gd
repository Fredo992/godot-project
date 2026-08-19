extends TextureRect

var open_menu: MyPopupMenu = null
var menu_shape: Rect2

#
	#menu_istanza = menu_scena.instantiate() 
		#menu_istanza._on_instance(option_menu)
		#add_child(menu_istanza)
		#menu_istanza.position = Vector2.ZERO
		#request_menu_open.emit(menu_istanza, menu_istanza.get_node("SfondoMenu").get_global_rect())


func _ready() -> void:
	# Collega tutti i MapObject figli che sono già presenti nella scena
	for child in get_children():
		if child is MapObject:
			_connect_map_object(child)

# Funzione per collegare i segnali di un MapObject (da usare anche se ne istanzi di nuovi a runtime)
func _connect_map_object(map_obj: MapObject) -> void:
	map_obj.request_menu_open.connect(_on_menu_requested)

func _on_menu_requested(option_menu) -> void:
	if open_menu:
		open_menu.queue_free()
		open_menu = null

	var menu_type = AssetLoader.get_resource("menu", "popup_menu.tscn", "tscn") as PackedScene
	open_menu = menu_type.instantiate() as MyPopupMenu
	add_child(open_menu)

	open_menu.position = get_local_mouse_position()
	open_menu._on_instance(option_menu)

	menu_shape = open_menu.menu_rect
	print(menu_shape)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if open_menu:
			var mouse_pos = get_local_mouse_position()
			if not menu_shape.has_point(mouse_pos):
				open_menu.queue_free()
				open_menu = null

extends Control


var visible_rows = 5
var open_menu: MyPopupMenu
var menu_shape: Rect2

func _ready() -> void:
	var screen_heigth = get_viewport().get_visible_rect().size.y
	var screen_width = get_viewport().get_visible_rect().size.x
	var total_map_height = screen_heigth * visible_rows
	var map_generator = MapGenerator.new(total_map_height, screen_width)
	var map_cache = map_generator._generate_map()
	for node: MapObject in map_cache:
		node.request_menu_open.connect(_on_menu_requested)
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

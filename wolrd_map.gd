extends TextureRect

var open_menu: Control = null
var menu_shape

func _ready() -> void:
	add_to_group("world_map")
	InputManager.subscribe_click_ui(_on_map_clicked)

					#
					#
func _on_map_clicked(context: InputEvent) -> void:
	
	if context is InputEventMouseButton and context.pressed and context.button_index == MOUSE_BUTTON_LEFT:

		var mouse_pos = context.global_position
		if (open_menu):
			if !menu_shape.has_point(mouse_pos) && open_menu.visible:
				open_menu.visible = false
		

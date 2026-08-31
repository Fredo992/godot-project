
class_name MyPopupMenu extends Control

var menu_rect: Rect2
var button_style_normal = AssetLoader.get_resource("style", "FF7Button.tres", "tres")
var button_style_hover =  AssetLoader.get_resource("style", "HoverButton.tres", "tres")
var button_style_pressed =  AssetLoader.get_resource("style", "PressedButton.tres", "tres")
@export var options_container: Control 

func _on_instance(options: Dictionary[String, Callable]):
	options_container.add_theme_constant_override("separation", 1)
	for key in options.keys():
		var newButton = Button.new()
		_set_button_styles(newButton)
		_set_button_font(newButton)
		_setup_button_behavior(newButton, key, options[key])
		options_container.add_child(newButton)
		
	var size = $SfondoMenu/OptionsContainer.get_combined_minimum_size()
	menu_rect = Rect2($SfondoMenu/OptionsContainer.global_position, size)
	
#to debug visually
func _draw() -> void:
	if menu_rect:
		var local_rect = Rect2(menu_rect.position - global_position, menu_rect.size)
		draw_rect(local_rect, Color(1.0, 0.0, 0.0, 0.3), true)
		draw_rect(local_rect, Color(1.0, 0.0, 0.0, 1.0), false, 2.0)

func _setup_button_behavior(button: Button, text: String, behavior: Callable):
	button.text = text
	button.pressed.connect(behavior)
	button.mouse_entered.connect(button.grab_focus)
	button.mouse_filter = Control.MOUSE_FILTER_STOP
	
func _set_button_font(button: Button):
	button.add_theme_font_size_override("font_size", 9)
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT

func _set_button_styles(button: Button):
	button.add_theme_stylebox_override("normal", button_style_normal)
	button.add_theme_stylebox_override("hover", button_style_hover)
	button.add_theme_stylebox_override("pressed", button_style_pressed)
	button.add_theme_stylebox_override("focus", button_style_hover)

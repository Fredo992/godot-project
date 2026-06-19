extends Control

var button_style_normal = preload("res://style/FF7Button.tres")
var button_style_hover = preload("res://style/HoverButton.tres")
var button_style_pressed = preload("res://style/PressedButton.tres")
@onready var out_of_border_sheet: TextureRect = $OutOfBorderSheet
var is_menu_istantiate: bool = false

func _on_instance(options: Dictionary[String, Callable]):
	$SfondoMenu/OptionsContainer.add_theme_constant_override("separation", 1)
	for key in options.keys():
		var newButton = Button.new()
		_set_button_styles(newButton)
		_set_button_font(newButton)
		_setup_button_behavior(newButton, key, options[key])
		$SfondoMenu/OptionsContainer.add_child(newButton)
		
	is_menu_istantiate = true
	#InputManager.subscribe_click_ui(sub)

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


#func sub(context):
	## Se il menu è già invisibile o lo sheet non esiste, non fare nulla
	#if not visible or out_of_border_sheet == null:
		#return
#
	#if context is InputEventMouseButton and context.pressed and context.button_index == MOUSE_BUTTON_LEFT:
#
		#await get_tree().process_frame
		#
		#if !is_menu_istantiate:
			#return
		#if not visible:
			#return
			#
		#var sheet_rect: Rect2 = out_of_border_sheet.get_global_rect()
		#
		#if sheet_rect.has_point(context.global_position):
##
			#var menu_rect = $SfondoMenu.get_global_rect()
			#if menu_rect.has_point(context.global_position):
				#print(menu_rect)
				#return
				#
			#visible = false

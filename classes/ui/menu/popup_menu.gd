extends Control

func _on_instance(options: Dictionary[String, Callable]):
	for key in options.keys():
		var newButton = Button.new()
		newButton.text = key
		newButton.pressed.connect(options[key])
		newButton.mouse_filter = Control.MOUSE_FILTER_STOP
		$SfondoMenu/OptionsContainer.add_child(newButton)
	

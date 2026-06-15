extends MapObject

func _on_mouse_click() -> void:
	print("ho cliccato castello ")


func _setup() -> void:
	sprite.texture = SpritesLoader.fixed_sprites["place_holder_castle.png"]

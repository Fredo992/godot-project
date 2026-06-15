
extends MapObject

func _on_mouse_click() -> void:
	print("ho cliccato casa ")


func _setup() -> void:
	sprite.texture = SpritesLoader.random_sprites["place_holder_house.png"]

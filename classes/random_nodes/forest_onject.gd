extends MapObject

func _on_mouse_click() -> void:
	print("queste sono le opzioni " + str(option_menu))
	print(MENU_TENDINA_SCENE is PackedScene)


func _setup() -> void:
	sprite.texture = SpritesLoader.random_sprites["place_holder_forest.png"]
	option_menu = {1: "entra", 2: "combatti", 3: "esci"}

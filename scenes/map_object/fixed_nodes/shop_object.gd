extends MapObject


func _setup() -> void:

	var path = AssetLoader.get_file("fixed", "place_holder_shop.png")
	var resource = load(path)
	
	var texture: Texture2D = resource as Texture2D
	sprite.texture = texture
	_setup_options_menu({
	"entra": func(): print("sono entrato allo shop  "),
	"compra ": func(): print("compra qualcosa si "),
	"rapina": func(): print("ti spacco il culo kid"),
	"esci": func(): print("sono uscito dal negozio ")
})

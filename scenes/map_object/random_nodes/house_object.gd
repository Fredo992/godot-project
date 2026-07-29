
extends MapObject


func _setup() -> void:
	var path = AssetLoader.get_file("random", "place_holder_house.png")
	var resource = load(path)
	var texture: Texture2D = resource as Texture2D
	sprite.texture = texture
	_setup_options_menu({
	"entra": func(): print("sono entrato al villaggio "),
	"riposati": func(): print("ronf ronf ronf ronf zzzz"),
	"taverna": func(): print("prendi una quest"),
	"combatti ": func(): print("ucciderò tutti questi contadini"),
	"esci": func(): print("sono uscito dal villaggio"),
})

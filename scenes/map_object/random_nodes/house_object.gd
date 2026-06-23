
extends MapObject


func _setup() -> void:
	sprite.texture = SpritesLoader.random_sprites["place_holder_house.png"]
	_setup_options_menu({
	"entra": func(): print("sono entrato al villaggio "),
	"riposati": func(): print("ronf ronf ronf ronf zzzz"),
	"taverna": func(): print("prendi una quest"),
	"combatti ": func(): print("ucciderò tutti questi contadini"),
	"esci": func(): print("sono uscito dal villaggio"),
})

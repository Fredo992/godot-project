
extends MapObject


func _setup() -> void:
	sprite.texture = JsonWriter.path_dictionary["random"][2]
	_setup_options_menu({
	"entra": func(): print("sono entrato al villaggio "),
	"riposati": func(): print("ronf ronf ronf ronf zzzz"),
	"taverna": func(): print("prendi una quest"),
	"combatti ": func(): print("ucciderò tutti questi contadini"),
	"esci": func(): print("sono uscito dal villaggio"),
})

extends MapObject



func _setup() -> void:
	var path = JsonWriter.path_dictionary["fixed"][0]
	var resource = load(path)
	var texture: Texture2D = resource as Texture2D
	sprite.texture = texture
	_setup_options_menu({
	"entra": func(): print("sono entrato al castello "),
	"combatti ": func(): print("stai combattendo il re matto"),
	"esci": func(): print("sono uscito dal castello "),
	"blabblo": func(): print("questa è la funzione nuova")
})

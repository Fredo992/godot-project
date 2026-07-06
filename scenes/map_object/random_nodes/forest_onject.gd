extends MapObject



func _setup() -> void:
	var path = JsonWriter.path_dictionary["random"][1]
	var resource = load(path)
	var texture: Texture2D = resource as Texture2D
	sprite.texture = texture
	_setup_options_menu({
	"entra": func(): print("sono entrato nella foresta buia "),
	"combatti ": func(): print("stai combattendo i lupi "),
	"esci": func(): print("sono uscito dalla foresta  "),
	"bigio": func(): print("hai incontrato dark bigi")
})

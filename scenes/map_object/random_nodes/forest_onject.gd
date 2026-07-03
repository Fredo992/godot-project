extends MapObject



func _setup() -> void:
	sprite.texture = JsonWriter.path_dictionary["random"][1]
	_setup_options_menu({
	"entra": func(): print("sono entrato nella foresta buia "),
	"combatti ": func(): print("stai combattendo i lupi "),
	"esci": func(): print("sono uscito dalla foresta  "),
	"bigio": func(): print("hai incontrato dark bigi")
})

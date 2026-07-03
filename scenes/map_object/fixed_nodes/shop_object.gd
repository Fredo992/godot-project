extends MapObject


func _setup() -> void:
	sprite.texture = JsonWriter.path_dictionary["fixed"][0]
	sprite.texture = JsonWriter.fixed_sprites["fixed"][0]
	_setup_options_menu({
	"entra": func(): print("sono entrato allo shop  "),
	"compra ": func(): print("compra qualcosa si "),
	"rapina": func(): print("ti spacco il culo kid"),
	"esci": func(): print("sono uscito dal negozio ")
})

extends MapObject



func _setup() -> void:
	sprite.texture = SpritesLoader.fixed_sprites["place_holder_castle.png"]
	_setup_options_menu({
	"entra": func(): print("sono entrato al castello "),
	"combatti ": func(): print("stai combattendo il re matto"),
	"esci": func(): print("sono uscito dal castello "),
	"blabblo": func(): print("questa è la funzione nuova")
})

extends MapObject


func _setup() -> void:
	sprite.texture = SpritesLoader.fixed_sprites["place_holder_shop.png"]
	_setup_options_menu({
	"entra": func(): print("sono entrato allo shop  "),
	"compra ": func(): print("compra qualcosa si "),
	"rapina": func(): print("ti spacco il culo kid"),
	"esci": func(): print("sono uscito dal castello ")
})

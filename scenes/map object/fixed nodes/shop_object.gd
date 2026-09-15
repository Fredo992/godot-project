extends MapObject


func _setup() -> void:

	var resource = AssetLoader._get_resource("fixed", "place_holder_shop.png")
	var texture: Texture2D = resource as Texture2D
	sprite.texture = texture
	_setup_options_menu({
	"entra": func(): print("sono entrato allo shop  "),
	"compra ": func(): print("compra qualcosa si "),
	"rapina": func(): print("ti spacco il culo kid"),
	"esci": func(): print("sono uscito dal negozio ")
})

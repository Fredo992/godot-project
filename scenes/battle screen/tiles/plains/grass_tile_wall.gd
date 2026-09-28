extends BattleTile


func _setup() -> void:
	self.sprite.texture = AssetLoader._get_resource("tiles","tile_wall.png")

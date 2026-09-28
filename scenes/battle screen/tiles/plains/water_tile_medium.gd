extends BattleTile


func _setup() -> void:
	self.sprite.texture = AssetLoader._get_resource("tiles","water_tile_medium.png")

extends Node

func _on_button_pressed_exit():
	print("CLICK")
	GameManager.change_scene(AssetLoader.get_file("world_map", "WorldMap.tscn", "tscn"))

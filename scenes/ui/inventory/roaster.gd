extends Node

func _on_button_pressed_exit():
	print("CLICK")
	GameManager._change_scene(AssetLoader._get_file("world map", "WorldMap.tscn", "tscn"))

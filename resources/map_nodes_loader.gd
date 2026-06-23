
extends Node

var fixed_nodes: Dictionary
var random_nodes: Dictionary


func _get_fixed_scenes():
	return fixed_nodes
func _get_random_scenes():
	return random_nodes


func _ready():
	fixed_nodes = load_folder("res://scenes/map_object/fixed_nodes")
	random_nodes = load_folder("res://scenes/map_object/random_nodes")
	
	print({"Indirizzo logico (hash): ": hash(fixed_nodes)})
	print("scenes from folder \"scenes/fixed_nodes\" \"scenes/random_nodes\" has been loaded ")


func load_folder(folder_name: String) -> Dictionary:
	var scenes: Dictionary
	var directory = DirAccess.open(folder_name)
	if (directory):
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while(file_name != ""):
			if !directory.current_is_dir():
				if file_name.ends_with(".tscn"):
					var file = load(folder_name.path_join(file_name))
					if (file is PackedScene):
						scenes[file_name] = file
						
			file_name = directory.get_next()
	
	print(scenes.keys())
	return scenes

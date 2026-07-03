
extends Node

var fixed_nodes: Dictionary
var random_nodes: Dictionary


func _get_fixed_scenes():
	return fixed_nodes
func _get_random_scenes():
	return random_nodes
const ROOT = "res://scenes"

func _ready():
	fixed_nodes = load_folder("res://scenes/map_object/fixed_nodes")
	random_nodes = load_folder("res://scenes/map_object/random_nodes")
	#---
	print("Running: map_nodes_loader")
	test_scan(ROOT)
	
	

var folders_to_ignore = [
	"input"
]


func test_scan(path: String):
	print(path)
	var pointer = DirAccess.open(path)
	pointer.list_dir_begin()
	var folder = pointer.get_current_dir()
	var file_name = pointer.get_next()
	var key = pointer.get_current_dir()
	#inseriscilo tra i controlli
	
	while(not file_name == ""):
		if(!file_name == "." or !file_name == ".."):
			if folders_to_ignore.has(file_name) or file_name.ends_with(".import"):
				file_name = pointer.get_next()
				continue
			var nextPointerPath = path.path_join(file_name)
			if (pointer.current_is_dir()):

				test_scan(nextPointerPath)
			else:
				return
				
		file_name = pointer.get_next()



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
	
	#print(scenes.keys())
	return scenes

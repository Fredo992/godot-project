extends Node

var fixed_sprites: Dictionary
var random_sprites: Dictionary


func _ready():
	
	fixed_sprites = load_folder("res://resources/sprites/map nodes/fixed")
	random_sprites = load_folder("res://resources/sprites/map nodes/random")
	if(fixed_sprites.is_empty() && random_sprites.is_empty()):
		print("sprites folders are empty!!!")
		return


func load_folder(folder_name: String) -> Dictionary:
	var sprites: Dictionary
	var directory = DirAccess.open(folder_name)
	if (directory):
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while(file_name != ""):
			if !directory.current_is_dir():
				if file_name.ends_with(".png") or file_name.ends_with(".png.import"):
					var clean_name = file_name.trim_suffix(".import")
					var file = load(folder_name.path_join(clean_name))
					if (file is Texture2D):
						sprites[clean_name] = file
						
			file_name = directory.get_next()
	
	print(sprites.keys())
	return sprites

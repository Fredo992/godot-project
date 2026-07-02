extends Node


# Questo è il tuo "Configuratore"
const ASSET_CONFIG = {
	"PNG": ".png",
	"SCENE": ".tscn"
}

const ROOT = "res://resources"


var path_dictionary: Dictionary[String, Array] = {}



func is_folder_valid(file_path: String):
	return ASSET_CONFIG.keys().has(file_path.get_extension())

	
	
func _ready():
	# Iniziamo la scansione dalla root, tutto qui.
	test_scan(ROOT)
	print(path_dictionary)


func test_scan(path: String):
	
	var pointer = DirAccess.open(path)
	if not pointer: return
	pointer.list_dir_begin()
	var file_name = pointer.get_next()
	while(file_name != ""):
		if file_name != "." and file_name != "..":
			var current_path = path.path_join(file_name)
			if (file_name == "asset_loader"):
				file_name = pointer.get_next()
				continue
			
			if(pointer.current_is_dir()):
				test_scan(current_path)
			else:
				if(file_name.ends_with(".import")):
					file_name = pointer.get_next()
					continue
				else:
					if(!path_dictionary.has(path)):
						path_dictionary[path] = []
						path_dictionary[path].append(file_name)
					else:
						
						path_dictionary[path].append(file_name)
			file_name = pointer.get_next()

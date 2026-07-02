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
	print(scanned_folders)
	print(path_dictionary)

var scanned_folders = []
func test_scan(path: String):
	var flag = false
	if (scanned_folders.has(path.trim_suffix("/").get_file())):
		print("CE LAAAAA")
		flag = true
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
					
					var key = get_dictionary_key_from_dir(path)
					if (flag):
						key = update_existing_key(key)
						path_dictionary[key] = []
						path_dictionary[key].append(file_name)
						scanned_folders.append(key)
						
					if(!path_dictionary.has(key)):
						
						path_dictionary[key] = []
						path_dictionary[key].append(file_name)
						scanned_folders.append(path.trim_suffix("/").get_file())
					else:
						
						path_dictionary[key].append(file_name)
			file_name = pointer.get_next()
	


func get_dictionary_key_from_dir(path):
	return path.trim_suffix("/").get_file()
	

func update_existing_key(key):
	return key.path_join(str(scanned_folders.count(key)))

extends Node


const ROOT = "res://"
const folders_to_ignore = ["asset_loader"]
var valid_extensions = ["png", "jpg", "jpeg", "tscn", "tres", "txt"]
var path_dictionary: Dictionary[String, Array] = {}


func _get_resource(key: String):
	if(path_dictionary.keys().has(key)):
		return path_dictionary[key]
	


func _ready():
	test_scan(ROOT)
	print("--- Asset Loader Caricato ---")
	# Facciamo un print carino per vedere la struttura
	for key in path_dictionary:
		print(key + ": " + str(path_dictionary[key].size()))

func test_scan(path: String):

	var pointer = DirAccess.open(path)
	if not pointer: return

	pointer.list_dir_begin()
	
	var folder_name = pointer.get_current_dir().get_file()
	

	var file_name = pointer.get_next()
	
	while file_name != "":
		if file_name == "." or file_name == "..":
			file_name = pointer.get_next()
			continue

		if folders_to_ignore.has(file_name) or file_name.ends_with(".import"):
			file_name = pointer.get_next()
			continue
			
		var current_path = path.path_join(file_name)
		
		if pointer.current_is_dir():
			test_scan(current_path)
		else:
			var ext = file_name.get_extension().to_lower()
			if valid_extensions.has(ext):
				if not path_dictionary.has(folder_name):
					path_dictionary[folder_name] = []
				path_dictionary[folder_name].append(current_path)
		
		file_name = pointer.get_next()
		

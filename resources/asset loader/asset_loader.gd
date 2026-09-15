extends Node


const ROOT = "res://"
const folders_to_ignore = ["asset_loader"]

var fallbacks = {
		"png": "no_sprite_error.png",
		"jpg": "no_sprite_error.png",
		"jpeg": "no_sprite_error.png",
		"tres": "no_sprite_error.png",
		"tscn": "fallbackNode.tscn",
		"txt": "fallbacktxt.txt"
	}
	

var asset_dictionary: Dictionary[String, Dictionary] = {}
var resource_cache: Dictionary[String, Resource] = {}

func _ready():
	_load_folders(ROOT)

func _get_resource(folder_name_key: String, file_name_key: String, expected_extention: String = "none") -> Resource:
	var path = _get_file(folder_name_key, file_name_key, expected_extention)  
	if not resource_cache.has(path):
		resource_cache[path] = load(path)
	return resource_cache[path]

func _get_resource_from_folder(folder: Dictionary):
	var resources = []
	for file in folder.values():
		if not resource_cache.has(file):
			resource_cache[file] = load(file)
		resources.append(resource_cache[file])
	return resources

func _get_folder(folder_name_key: String):
	return asset_dictionary.get(folder_name_key, asset_dictionary["fallback resources"])

func _get_file(folder_name_key: String, file_name_key: String, expected_extention: String = "none") -> String:
	if expected_extention != "none":
		assert(fallbacks.has(expected_extention), "invalid extention: " + expected_extention)
	
	var fetched_folder: Dictionary = _get_folder(folder_name_key)
	var fallback_folder: Dictionary = _get_folder("fallback resources")
	
	var default_fallback = fallbacks.get(expected_extention.to_lower(), "")
	
	return fetched_folder.get(file_name_key, fallback_folder.get(default_fallback))



func _load_folders(path: String):
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
			_load_folders(current_path)
		else:
			var ext = file_name.get_extension().to_lower()
			if fallbacks.has(ext):
				if(!asset_dictionary.has(folder_name)):
					asset_dictionary[folder_name] = {}
				if asset_dictionary[folder_name].has(file_name):
					push_error("file conflitc: " + file_name + " already exists in another project folder, resource " + file_name + " won't be loaded")
				else:
					asset_dictionary[folder_name][file_name] = current_path
		file_name = pointer.get_next()
		

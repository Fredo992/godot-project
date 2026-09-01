extends Node


const ROOT = "res://"
const folders_to_ignore = ["asset_loader"]
const valid_extensions = ["png", "jpg", "jpeg", "tscn", "tres", "txt"]

var asset_dictionary: Dictionary[String, File_dictionary] = {}

var resource_cache: Dictionary[String, Resource] = {}

func _ready():
	load_folders(ROOT)
	print("--- Asset Loader Caricato ---")
	print(asset_dictionary["world_map"])
	print(asset_dictionary["character"])




func get_resource(folder_name_key: String, file_name_key: String, expected_extention: String = "none") -> Resource:
	var path = get_file(folder_name_key, file_name_key, expected_extention)  
	if not resource_cache.has(path):
		print("carico risorsa " + path )
		resource_cache[path] = load(path)
	return resource_cache[path]




func are_keys_valid(folder_name_key: String, file_name_key:String) -> bool:
	
	var result: bool =  asset_dictionary.keys().has(folder_name_key) && asset_dictionary[folder_name_key].folder_dictionary.keys().has(file_name_key)
	if (not result):
		push_error("folder name or file name is invalid")
	return result

func get_folder(folder_name_key: String):
	assert(asset_dictionary.keys().has(folder_name_key), "no folder with the given name: " + folder_name_key + " has been found in game resources")
	return asset_dictionary[folder_name_key]

func get_file(folder_name_key: String, file_name_key:String, expected_extention: String = "none") -> String:
	if(expected_extention != "none"):
		assert(valid_extensions.has(expected_extention), "invalid extention: " + expected_extention + " for method get_file in AssetLoader")
	
	match expected_extention.to_lower():
		"none":
			pass
		"png", "jpg", "jpeg", "tres":
			if (not are_keys_valid(folder_name_key, file_name_key)):
				return asset_dictionary["exceptions"].folder_dictionary["no_sprite_error.png"]
		"tscn":
			if (not are_keys_valid(folder_name_key, file_name_key)):
				return asset_dictionary["exceptions"].folder_dictionary["fallbackNode.tscn"]
		"txt":
			if (not are_keys_valid(folder_name_key, file_name_key)):
				return asset_dictionary["fallback_resources"].folder_dictionary["fallbacktxt.txt"]
	return asset_dictionary[folder_name_key].folder_dictionary[file_name_key]
		



func load_folders(path: String):
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
			load_folders(current_path)
		else:
			var ext = file_name.get_extension().to_lower()
			if valid_extensions.has(ext):
				if(!asset_dictionary.keys().has(folder_name)):
					asset_dictionary[folder_name] = File_dictionary.new()
				if(!asset_dictionary[folder_name].folder_dictionary.keys().has(file_name)):
					asset_dictionary[folder_name].add_file(file_name, current_path)
		
		file_name = pointer.get_next()
		

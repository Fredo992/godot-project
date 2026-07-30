extends Node


const ROOT = "res://"
const folders_to_ignore = ["asset_loader"]
const valid_extensions = ["png", "jpg", "jpeg", "tscn", "tres", "txt"]




var asset_dictionary: Dictionary[String, File_dictionary] = {}

func are_key_invalid(folder_name_key: String, file_name_key:String):
	return not asset_dictionary.keys().has(folder_name_key) || not asset_dictionary[folder_name_key].folder_dictionary.keys().has(file_name_key)

func get_file(folder_name_key: String, file_name_key:String, expected_extention: String = "none"):
	
	match expected_extention.to_lower():
		"":
			return # Equivale a 'none' (stringa vuota)
		"png":
			if (are_key_invalid(folder_name_key, file_name_key)):
				return asset_dictionary["exceptions"].folder_dictionary["no_sprite_error.png"]
		_:
		# Il trattino basso '_' è il caso di fallback (default)
			pass

	var fetch_file_path = asset_dictionary[folder_name_key].folder_dictionary[file_name_key]
	if (expected_extention == "none"):
		return fetch_file_path
	

func _ready():
	
	test_scan(ROOT)
	print("--- Asset Loader Caricato ---")
	print(asset_dictionary["random"])

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
				if(!asset_dictionary.keys().has(folder_name)):
					asset_dictionary[folder_name] = File_dictionary.new()

				if(!asset_dictionary[folder_name].folder_dictionary.keys().has(file_name)):
					asset_dictionary[folder_name].add_file(file_name, current_path)
		
		file_name = pointer.get_next()
		

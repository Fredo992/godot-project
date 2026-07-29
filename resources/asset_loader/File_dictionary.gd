extends Node
class_name File_dictionary


var folder_dictionary: Dictionary[String, String] = {}



func add_file(file_name_key:String, file_path:String):
	if(!file_path is String):
		push_error("dictionary value must be a valid path")
		return
	folder_dictionary[file_name_key] = file_path



func _to_string() -> String:
	# Esempio: restituisce la rappresentazione in stringa del dizionario intero
	return str(folder_dictionary)

extends Node


# Questo è il tuo "Configuratore"
const ASSET_CONFIG = {
	"PNG": ".png",
	"SCENE": ".tscn"
}

const ROOT = "res://resources"


var directory = DirAccess.open(ROOT)
var flagged_folder = null
var path_dictionary: Dictionary[String, Array] = {}



func is_folder_valid(file_extension):
	if(ASSET_CONFIG.keys().has(file_extension)):
		return ASSET_CONFIG[file_extension]



var relative_path = ROOT

func _ready():
	# Iniziamo la scansione dalla root, tutto qui.
	recursive_scan(ROOT)
	print(path_dictionary)

func recursive_scan(current_path: String):

	# 1. Se già letta, fermati (Evita loop infiniti)
	if flagged_folders.has(current_path):
		return
	flagged_folders.append(current_path)
	
	# 2. Crea un pointer LOCALE (non globale!)
	var dir = DirAccess.open(current_path)
	if not dir: return

	dir.list_dir_begin()
	var item = dir.get_next()

	while item != "":
		if item != "." and item != "..":

			var full_path = current_path.path_join(item)
			print(full_path)
			if dir.current_is_dir():
				# Chiamata ricorsiva: il 'dir' corrente resta "congelato" 
				# qui finché questa funzione non finisce
				recursive_scan(full_path)
			else:
				# È un file, aggiungilo al dizionario
				if !path_dictionary.has(current_path):
					path_dictionary[current_path] = []
				if not item.ends_with(".import"):
					path_dictionary[current_path].append(item)
		
		item = dir.get_next()


var flagged_folders = []

func scan_path(path):
	var pointer = DirAccess.open(path)
	pointer.list_dir_begin()
	var file_name = pointer.get_next()
	while(file_name != ""):
		if file_name == "." or file_name == "..":
			file_name = pointer.get_next()
			continue
		if file_name.ends_with(".import"):
			file_name = pointer.get_next()
			continue
		
		if (!path_dictionary.keys().has(pointer.get_current_dir())):
			path_dictionary[pointer.get_current_dir()] = []
		
		path_dictionary[pointer.get_current_dir()].append(file_name)
		flagged_folders.append(pointer.get_current_dir())
		file_name = pointer.get_next()
		
	

func is_folders_finished():
	var pointer = DirAccess.open(ROOT)
	pointer.list_dir_begin()
	var folder_name = pointer.get_next()
	while(folder_name != ""):
		folder_name = pointer.get_next()
	
	
	
	
	

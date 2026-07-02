extends Node

const ASSET_CONFIG = {
	"PNG": ".png",
	"SCENE": ".tscn"
}

const ROOT = "res://resources"

var path_dictionary: Dictionary = {}
var folder_counters: Dictionary = {}

func _ready():
	test_scan(ROOT)
	print("--- RISULTATO FINALE ---")
	test_scan(ROOT)
	print(path_dictionary)

func test_scan(path: String):
	var pointer = DirAccess.open(path)
	if not pointer: 
		return
	
	pointer.list_dir_begin()
	
	# 1. Determiniamo la chiave per la cartella corrente
	var base_key = path.trim_suffix("/").get_file()
	var final_key = generate_unique_key(base_key)
	
	# Inizializziamo il dizionario per questa chiave
	if not path_dictionary.has(final_key):
		path_dictionary[final_key] = []
		
	var file_name = pointer.get_next()
	
	# 2. Ciclo di scansione
	while(file_name != ""):
		if file_name != "." and file_name != "..":
			var current_path = path.path_join(file_name)
			
			# Filtri di esclusione
			if file_name == "asset_loader" or file_name.ends_with(".import"):
				file_name = pointer.get_next()
				continue
			
			# Ricorsione o inserimento
			if pointer.current_is_dir():
				test_scan(current_path)
			else:
				path_dictionary[final_key].append(file_name)
		
		file_name = pointer.get_next()

func generate_unique_key(key: String) -> String:
	# Se la chiave è già stata usata, ne creiamo una versione indicizzata
	if not folder_counters.has(key):
		folder_counters[key] = 0
		return key
	else:
		folder_counters[key] += 1
		return key + "_" + str(folder_counters[key])

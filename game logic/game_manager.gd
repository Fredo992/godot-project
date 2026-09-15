
extends Node

var map_cache: Array[Node]


# Funzione per cambiare scena ripulendo tutto in modo sicuro
func change_scene(scene_path: String) -> void:
	var risultato = get_tree().change_scene_to_file(scene_path)
	if risultato != OK:
		print("Errore nel caricamento della scena: ", scene_path)
		
func save_map_cache(_map_cache: Array[Node]):
	map_cache = _map_cache


extends Node

var map_cache: Array[Node]

func _change_scene(scene_path: String) -> void:
	var risultato = get_tree().change_scene_to_file(scene_path)
	if risultato != OK:
		print("Errore nel caricamento della scena: ", scene_path)
		
func _save_map_cache(_map_cache: Array[Node]):
	map_cache = _map_cache

extends RefCounted
class_name MapGenerator

var number_of_rows = 20
var screen_height: float
var screen_width: float

func _init(height: float, width: float) -> void:
	screen_height = height
	screen_width = width

func _getRowsSpacing(rows):
	return screen_height / (rows + 1)

	
func _getEntityPositionsOnX(number_of_entities, entity_y):
	var entity_positions: Array = []
	var space_between_entities = screen_width / (number_of_entities + 1)
	for i in range(number_of_entities):
		var entity_x = space_between_entities * ( i + 1)
		entity_positions.append(Vector2(entity_x, entity_y))
	return entity_positions


static func _castToPackedScenes(asset_dictionary: Dictionary, key: String):
	var file_dictionary:Dictionary = asset_dictionary[key]
	var scene_array: Array[PackedScene] = []

	for value in file_dictionary.values():
		var path = value
		if ResourceLoader.exists(path):
			var scene = load(path)
			if scene is PackedScene:
				scene_array.append(scene)
		else:
			print("Attenzione: Il path è errato o la risorsa non esiste: ", path)
	return scene_array
	
func _makeInstanceOfScene(scene :PackedScene, entity_pos :Vector2):
	var instance = scene.instantiate()
	instance.position = entity_pos
	return instance

func _generate_map() -> Array[Node]:
	var space_between_rows = _getRowsSpacing(number_of_rows)
	var fixed_scenes = _castToPackedScenes(AssetLoader.asset_dictionary, "fixed nodes")
	var random_scenes =  _castToPackedScenes(AssetLoader.asset_dictionary, "random nodes")
	var map_cache: Array[Node]
	
	for i in range(number_of_rows):
		if (i == 0):
			var positions = _getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			map_cache.append(_makeInstanceOfScene(fixed_scenes[0], positions[0]))
		elif (i == number_of_rows -1):
			var positions = _getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			map_cache.append(_makeInstanceOfScene(fixed_scenes[0], positions[0]))
		elif (i%4 == 0):
			var positions = _getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			map_cache.append(_makeInstanceOfScene(fixed_scenes[1], positions[0]))
		else:
			for entity_pos in _getEntityPositionsOnX(randi_range(1,4), (space_between_rows * (i+1))):
				map_cache.append(_makeInstanceOfScene(random_scenes[randi_range(1,random_scenes.size())-1], entity_pos))

	return map_cache

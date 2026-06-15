extends Node2D

const INTERACTABLE_SCENE: PackedScene = preload("res://map_object.tscn")

var number_of_rows = 20
var screen_height = 1040
var fixed_scenes
var random_scenes

func getRowsSpacing(number_of_rows):
	return screen_height / (number_of_rows + 1)

	
func getEntityPositionsOnX(number_of_entities, entity_y):
	var screen_width = get_viewport().get_visible_rect().size.x
	var entity_positions: Array = []
	var space_between_entities = screen_width / (number_of_entities + 1)
	for i in range(number_of_entities):
		var entity_x = space_between_entities * ( i + 1)
		entity_positions.append(Vector2(entity_x, entity_y))
	return entity_positions

func makeInstanceOfScene(scene :PackedScene, entity_pos :Vector2):
	var instance = scene.instantiate()
	add_child(instance)
	instance.position = entity_pos
	return instance




func _ready():	
	
	var space_between_rows = getRowsSpacing(number_of_rows)
	
	fixed_scenes = MapNodesLoader.fixed_nodes
	random_scenes = MapNodesLoader.random_nodes
	for i in range(number_of_rows):
		if (i == 0):
			var positions = getEntityPositionsOnX(1, (space_between_rows * (i+1)))

			makeInstanceOfScene(fixed_scenes["castle_object.tscn"], positions[0])
		elif (i == number_of_rows -1):
			var positions = getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			makeInstanceOfScene(fixed_scenes["castle_object.tscn"], positions[0])
		elif (i%4 == 0):
			var positions = getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			makeInstanceOfScene(fixed_scenes["shop_object.tscn"], positions[0])
		else:
			for entity_pos in getEntityPositionsOnX(randi_range(1,3), (space_between_rows * (i+1))):
				makeInstanceOfScene(random_scenes[random_scenes.keys().pick_random()], entity_pos)
			
		

	

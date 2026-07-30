extends Node2D


var number_of_rows = 16
var screen_height = 1040
var fixed_scenes
var random_scenes
var space_between_rows

func getRowsSpacing(rows):
	return screen_height / (rows + 1)

	
func getEntityPositionsOnX(number_of_entities, entity_y):
	var screen_width = get_viewport().get_visible_rect().size.x
	var entity_positions: Array = []
	var space_between_entities = screen_width / (number_of_entities + 1)
	for i in range(number_of_entities):
		var entity_x = space_between_entities * ( i + 1)
		entity_positions.append(Vector2(entity_x, entity_y))
	return entity_positions


func castToPackedScenes(asset_dictionary: Dictionary, key: String):
	var file_dictionary:File_dictionary = asset_dictionary[key]
	var scene_array: Array[PackedScene] = []
	for value in file_dictionary.folder_dictionary.values():
		var path = value
		var scene = load(path)
		if scene is PackedScene:
			scene_array.append(scene)
	return scene_array


func makeInstanceOfScene(scene :PackedScene, entity_pos :Vector2):
	var instance = scene.instantiate()
	add_child(instance)
	instance.position = entity_pos
	if instance.has_signal("request_menu_open"):
		instance.request_menu_open.connect(WorldMap._on_menu_requested)
	return instance

func _ready():	
	InputManager.subscribe_click_ui(_unhandled_input)
	space_between_rows = getRowsSpacing(number_of_rows)
	fixed_scenes = castToPackedScenes(AssetLoader.asset_dictionary, "fixed_nodes")
	random_scenes =  castToPackedScenes(AssetLoader.asset_dictionary, "random_nodes")
	for i in range(number_of_rows):
		if (i == 0):
			var positions = getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			makeInstanceOfScene(fixed_scenes[0], positions[0])
		elif (i == number_of_rows -1):
			var positions = getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			makeInstanceOfScene(fixed_scenes[0], positions[0])
		elif (i%4 == 0):
			var positions = getEntityPositionsOnX(1, (space_between_rows * (i+1)))
			makeInstanceOfScene(fixed_scenes[1], positions[0])
		else:
			for entity_pos in getEntityPositionsOnX(randi_range(1,4), (space_between_rows * (i+1))):
				makeInstanceOfScene(random_scenes[randi_range(1,random_scenes.size())-1], entity_pos)


var trascinamento_attivo: bool = false
var offset_y: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	# 1. Controlliamo il tasto destro per il trascinamento
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		trascinamento_attivo = event.pressed
		# Memorizziamo la differenza tra la posizione del mondo e il mouse al momento del click
		if trascinamento_attivo:
			offset_y = event.position.y - position.y
		
	# 2. Se muoviamo il mouse, spostiamo il mondo solo in verticale
	if event is InputEventMouseMotion and trascinamento_attivo:
		# Usiamo la posizione assoluta del mouse meno l'offset calcolato al click
		# Questo garantisce che la mappa segua il mouse senza usare il "relative"
		position.y = event.position.y - offset_y
		
		# Controllo superiore
		if position.y >= 0:
			position.y = 0

		if position.y <= -(screen_height - get_viewport_rect().size.y):
			position.y = -(screen_height - get_viewport_rect().size.y)

		position.x = 0.0
		

extends RefCounted
class_name River_Drawer

var grid_width
var grid_height

func _init(_grid_width, _grid_heigth):
	grid_width = _grid_width
	grid_height = _grid_heigth



func _draw_a_river():
	var x = 0
	var y = 0
	var tile_positions = []

	if randi() % 2 == 0:
		x = 0
		y = randi_range(0, grid_height -1)
	else:
		x = randi_range(0, grid_width -1 )
		y = 0

	var punto_partenza = Vector2i(x, y)
	
	var punto_arrivo = Vector2i((grid_width -1) - punto_partenza.x, (grid_height -1) - punto_partenza.y)
	
	var x_grow = 0
	var y_grow = 0
	if (punto_partenza.x != punto_arrivo.x):
		x_grow = 1 if punto_partenza.x < punto_arrivo.x else -1
	if (punto_partenza.y != punto_arrivo.y):
		y_grow = 1 if punto_partenza.y < punto_arrivo.y else -1
	print(x_grow)
	print(y_grow)

	var distanza_x = abs(punto_partenza.x - punto_arrivo.x)
	var distanza_y = abs(punto_partenza.y - punto_arrivo.y)
	var total_steps = distanza_x + distanza_y

	var diagonal_steps:float = min(distanza_x, distanza_y)
	var straight_steps:float = total_steps - (diagonal_steps * 2)

	print("partenza: " + str(punto_partenza))
	print("arrivo: " + str(punto_arrivo))
	print ("STEP TOTALI " + str(total_steps))
	print("diagonale: " + str(diagonal_steps))
	print("straight: " + str(straight_steps))

	var current_pos = punto_partenza
	while current_pos != punto_arrivo:
		
		#posso fare diagonale
		var can_do_diagonal = diagonal_steps > 0
		#posso fare dritto
		var can_do_straight = straight_steps > 0
		
		var do_diagonal = false
		#se hai entrambe tira moneta
		if can_do_diagonal and can_do_straight:
			#do diagonal tira moneta
			do_diagonal = (randi() % 2 == 0)
		elif can_do_diagonal:
			#se hai solo la diagonale
			do_diagonal = true
			
		if do_diagonal:
			# Muovi su entrambi gli assi (1 passo X + 1 passo Y)
			current_pos.x += x_grow
			current_pos.y += y_grow
			diagonal_steps -= 1
			total_steps -= 2  # Consuma 2 passi dal totale!
		#se non hai la diagonale
		else:
			# se x non è arrivata e x era la più grande da coprire O se y è arrivata già, vai dritto su x
			if (current_pos.x != punto_arrivo.x) and (distanza_x > distanza_y or current_pos.y == punto_arrivo.y):
				current_pos.x += x_grow
			#altrimenti y
			else:
				current_pos.y += y_grow
				
			straight_steps -= 1
			total_steps -= 1
			
		tile_positions.append(current_pos)
	return tile_positions

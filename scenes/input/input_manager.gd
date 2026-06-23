extends Node

enum input_state{
	UI,
	BATTLE
}

var _currentState = input_state.UI
var _subscribers: Dictionary[int, Array] = {
	input_state.UI: [],
	input_state.BATTLE: []
}

func subscribe_click_ui(callable: Callable):
	_subscribers[input_state.UI].append(callable)

func subscribe_click_battle(callable: Callable):
	_subscribers[input_state.BATTLE].append(callable)
	


func _input(event):
	# Se l'evento è già stato consumato da un controllo (bottone, ecc.),
	# Godot imposta questa proprietà automaticamente.
	if event is InputEventMouseButton and event.pressed:
		# Controlliamo se l'evento è già stato gestito (es. da un bottone)
		if event.is_echo(): # Piccolo controllo extra
			return
		
		# Il trucco è verificare se il click è avvenuto su un elemento Control
		# che ha il "mouse_filter" impostato su "Stop"
		# Usiamo 'get_viewport().gui_get_focus_owner()' per vedere se c'è un controllo attivo
		# O meglio ancora, lasciamo che la UI faccia il suo lavoro:
		
		# SOLUZIONE PULITA:
		if get_viewport().gui_is_dragging():
			return # Se stai trascinando, ignora il click
	if event is InputEventMouseButton and event.pressed:
		_gestisci_click_mouse(event)
		return
	if event is InputEventKey and event.pressed:
		return
	
	
func _gestisci_click_mouse(event: InputEventMouseButton) -> void:
	var subs_alive: Array = []
	
	# Smistiamo l'evento SOLO ai subscriber dello stato corrente 
	# che sono effettivamente interessati ai click del mouse
	for subscriber in _subscribers[_currentState]:
		if subscriber.is_valid():
			# Passiamo l'evento pulito (sappiamo già che è un click)
			subscriber.call(event)
			subs_alive.append(subscriber)
			
	_subscribers[_currentState] = subs_alive

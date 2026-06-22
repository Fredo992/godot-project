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
	# 1. FILTRO: È un click del mouse?
	if event is InputEventMouseButton and event.pressed:
		_gestisci_click_mouse(event)
		return
		
	# 2. FILTRO: È la pressione di un tasto sulla tastiera?
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

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
	var sopravvissuti: Array = []
	for subscriber in _subscribers[_currentState]:
		if subscriber.is_valid():
			subscriber.call(event)
			sopravvissuti.append(subscriber)
			
	_subscribers[_currentState] = sopravvissuti

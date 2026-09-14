class_name Stat
extends RefCounted

var stat_name: GameConstants.StatName
var final_value: int 
@export var base_value: int = 1

func _init(_base_value: int = 1, _stat_name = GameConstants.StatName.NONE):
	stat_name = _stat_name
	base_value = _base_value
	final_value = _base_value


var modifiers: Dictionary[GameConstants.stat_modifier, Array] = {
	GameConstants.stat_modifier.FLAT: [] as Array[int],
	GameConstants.stat_modifier.MULT: [] as Array[float]
}

func _increment_base_value(amount: int):
	base_value += amount

func _get_final_value() -> int:
	var flat_result = 0
	var mult_result = 1
	for mod in modifiers[GameConstants.stat_modifier.FLAT]:
		flat_result += mod
	for mod in modifiers[GameConstants.stat_modifier.MULT]:
		if(mod != 0):
			mult_result += mod
	mult_result = max(0.0, mult_result)
	final_value = round((base_value + flat_result) * mult_result)
	return final_value

func _add_modifier(value, modifier_type: GameConstants.stat_modifier) -> void:
	modifiers[modifier_type].append(value)

func _remove_modifier(value, modifier_type: GameConstants.stat_modifier) -> void:
	modifiers[modifier_type].erase(value)
	
func _clear_modifiers() -> void:
	for array: Array in modifiers.values():
		array.clear()	
		
func _is_equal(obj: Stat):
	if not obj:
		return false
	return obj.base_value == base_value && obj.final_value == final_value
	
	
func _is_equal_to_int(obj: int):
	if not obj:
		return false
	return obj == base_value && obj == final_value
	
func _to_string() -> String:
	return "%s: (Base: %d, Final: %d)" % [GameConstants.StatName.find_key(stat_name), base_value, _get_final_value()]

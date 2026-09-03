extends Resource
class_name ability


var effect: Callable
var target_type: int
var amount_value: int = 0
var geometry_shape: Vector2 = Vector2.ZERO
var id: int
var description: String

var to_implement: Callable = func(tar_type, amount: int = 0, num_of_targets: int = 0) -> void:
		print("")

func _invoke_ability(target_type: GameConstants.target_type, amount = 0, num_of_targets = 0):
	to_implement.call(target_type, amount, num_of_targets)

func _init(_effect: Callable, args: Dictionary) -> void:
	effect = _effect
	target_type = args["target_type"]
	amount_value = args["amount"]
	geometry_shape = args["geometry_shape"]
	

extends RefCounted
class_name Ability

const argument: GameConstants.AbilityArgument = GameConstants.AbilityArgument

var target_type: GameConstants.target_type
var geometry_shape: Vector2 = Vector2.ZERO

var amount_value: Stat = Stat.new(0, GameConstants.StatName.AMOUNT)
var ability_jp_cost: Stat
var ability_mana_cost: Stat

var ability_name: String
var ability_description: String

var is_ability_unlocked: bool = false

var to_implement: Callable = func(tar_type, amount: int = 0, num_of_targets: Array[AbstractEntity] = []) -> void:
		print("no implementation has been found")

func _invoke_ability(num_of_targets: Array[AbstractEntity]):
	print("AAAAAAAAAA")
	print(amount_value)
	to_implement.call(target_type, amount_value._get_final_value(), num_of_targets)
	print(num_of_targets[0])

func _to_string() -> String:
	return "[Name: %s | %s | %s | %s | %s]" % [
		ability_name, 
		GameConstants.target_type.find_key(target_type), 
		amount_value._to_string(),
		ability_mana_cost._to_string(), 
		ability_jp_cost._to_string()
	]

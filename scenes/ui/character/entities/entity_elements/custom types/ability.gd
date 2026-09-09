extends Resource
class_name Ability

const argument: GameConstants.AbilityArgument = GameConstants.AbilityArgument

var target_type: GameConstants.target_type
var geometry_shape: Vector2 = Vector2.ZERO

var amount_value: Stat = Stat.new(0, GameConstants.StatName.DAMAGE)
var ability_jp_cost: Stat
var ability_mana_cost: Stat

var ability_name: String
var ability_description: String

var is_ability_unlocked: bool

var to_implement: Callable = func(tar_type, amount: int = 0, num_of_targets: int = 0) -> void:
		print("no implementation has been found")

func _invoke_ability(num_of_targets = 0):
	to_implement.call(target_type, amount_value, num_of_targets)

func _init(_effect: Callable, args: Dictionary) -> void:
	to_implement = _effect
	target_type = args[argument.TARGET_TYPE]
	amount_value = args[argument.AMOUNT]
	if (target_type == GameConstants.target_type.AREA):
		if (args[argument.GEOMETRY_SHAPE] == null):
			push_error("geometry shape is required for area type ability")
		else:
			geometry_shape = args[argument.GEOMETRY_SHAPE]
	ability_jp_cost = args[argument.JP_COST]
	ability_name = args[argument.NAME]
	ability_description = args[argument.DESCRIPTION]
	ability_mana_cost = args[argument.MANA_COST]
	
func _to_string() -> String:
	return "[Name: %s | %s | %s | %s | %s]" % [
		ability_name, 
		GameConstants.target_type.find_key(target_type), 
		amount_value._to_string(),
		ability_mana_cost._to_string(), 
		ability_jp_cost._to_string()
	]

extends Node

const ability_arg: GameConstants.AbilityArgument = GameConstants.AbilityArgument
const Target_Type: GameConstants.target_type = GameConstants.target_type

func _ready() -> void:
	print("job test running")
	var ability = Ability.new(
		func(target_type, value, number_of_tar): 
			print("target type is " + str(GameConstants.target_type.find_key(target_type)) + " it damages by " + str(value) + " and hit number of targets of " + str(number_of_tar))
			print("pare funzionare"),
		{ability_arg.NAME: "fire bolt",
		ability_arg.JP_COST: Stat.new(30, GameConstants.StatName.JP_COST),
		ability_arg.AMOUNT: Stat.new(40, GameConstants.StatName.DAMAGE),
		ability_arg.TARGET_TYPE: GameConstants.target_type.SINGLE,
		ability_arg.MANA_COST: Stat.new(10, GameConstants.StatName.MANA_COST),
		ability_arg.DESCRIPTION: "shoot a bolt of fire to a single target"
		}
	)
	ability._invoke_ability()
	print(ability)

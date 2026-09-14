extends Node

const ability_arg: GameConstants.AbilityArgument = GameConstants.AbilityArgument
const Target_Type: GameConstants.target_type = GameConstants.target_type





func _ready() -> void:
	print("job test running")
	
	var job = MageJob.new()
	var ability:Ability = job._get_ability(1,0)
	var entity: AbstractEntity = AbstractEntity.new()
	ability._invoke_ability([entity])
	print(ability)
	

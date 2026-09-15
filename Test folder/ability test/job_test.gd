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
	var agility: Stat = Stat.new(10, GameConstants.StatName.DEX)
	var derived_stat: DerivedStat = DerivedStat.new(GameConstants.StatName.SPEED, agility, func(agility): return agility * 2)
	print("TEST STATISTICHE")
	print(agility)
	print(derived_stat)
	agility._increment_base_value(10)
	print(derived_stat)

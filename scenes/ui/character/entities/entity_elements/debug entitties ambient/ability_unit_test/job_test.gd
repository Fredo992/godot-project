extends Node

const ability_arg: GameConstants.AbilityArgument = GameConstants.AbilityArgument
const Target_Type: GameConstants.target_type = GameConstants.target_type





func _ready() -> void:
	print("job test running")
	var ability_array: Array[Ability] = [
	AbilityBuilder.new().set_effect(func(tar_type, amount, num_of_tar): print("jp cost 10")).set_amount(50).set_jp_cost(10).build(),
	AbilityBuilder.new().set_effect(func(tar_type, amount, num_of_tar): print("jp cost 20")).set_amount(50).set_jp_cost(20).build(),
	AbilityBuilder.new().set_effect(func(tar_type, amount, num_of_tar): print("jp cost 30")).set_amount(50).set_jp_cost(30).build(),
	AbilityBuilder.new().set_effect(func(tar_type, amount, num_of_tar): print("jp cost 40")).set_amount(50).set_jp_cost(40).build(),
	AbilityBuilder.new().set_effect(func(tar_type, amount, num_of_tar): print("jp cost 50")).set_amount(50).set_jp_cost(50).build(),
	AbilityBuilder.new().set_effect(func(tar_type, amount, num_of_tar): print("jp cost 20")).set_amount(50).set_jp_cost(20).build()
	]
	
	ability_array[0]._invoke_ability()
	print(ability_array[0])
	
	var job = Job.new(ability_array, "default")
	print(job)

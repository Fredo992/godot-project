extends RefCounted

var jp: Stat = Stat.new()
var lvl: Stat = Stat.new()
var job_name: String
var job_description: String

var abilities: Array[Ability]


func _get_available_abilities():
	var available_abilities: Array 
	for ability: Ability in abilities:
		if ability.is_ability_unlocked:
			available_abilities.append(ability)
	return available_abilities

extends RefCounted

class_name CharacterStat

const StatName = GameConstants.statName

@export var character_stats: Dictionary[GameConstants.statName , Stat] = {
	StatName.STR: Stat.new(),
	StatName.DEX: Stat.new(),
	StatName.CON: Stat.new(),
	StatName.INT: Stat.new(),
	StatName.WIS: Stat.new(),
	StatName.CHA: Stat.new(),
}

func _modify_base_stat(stat_name: GameConstants.statName, value):
	character_stats[stat_name].base_value += value
	
func _get_base_stat(stat_name: GameConstants.statName):
	return character_stats[stat_name]

func _get_final_stat(stat_name: GameConstants.statName):
	return character_stats[stat_name]._get_final_value()

func _to_string() -> String:
	var result = "CharacterStat: {\n"
	for key: GameConstants.statName in character_stats.keys():
		result += "  Stat %s: %s\n" % [StatName.find_key(key), character_stats[key]]
	result += "}"
	return result

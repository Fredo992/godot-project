extends RefCounted

class_name CharacterStat

const StatName = GameConstants.StatName

var character_stats: Dictionary[GameConstants.StatName , Stat] = {
	StatName.EXP: Stat.new(0),
	StatName.HP: Stat.new(10),
	StatName.MANA: Stat.new(10),
	StatName.STR: Stat.new(1),
	StatName.DEX: Stat.new(1),
	StatName.CON: Stat.new(1),
	StatName.INT: Stat.new(1),
	StatName.WIS: Stat.new(1),
	StatName.CHA: Stat.new(1),
}

func _modify_base_stat(stat_name: GameConstants.StatName, value):
	character_stats[stat_name].base_value += value
	
func _get_base_stat(stat_name: GameConstants.StatName):
	return character_stats[stat_name]

func _get_final_stat(stat_name: GameConstants.StatName):
	return character_stats[stat_name].final_value

func _to_string() -> String:
	var result = "CharacterStat: {\n"
	for key: GameConstants.StatName in character_stats.keys():
		result += "  Stat %s: %s\n" % [StatName.find_key(key), character_stats[key]]
	result += "}"
	return result

extends Node


const StatName = GameConstants.statName
const ModType = GameConstants.stat_modifier

func _ready():
	var character = CharacterStat.new()
	print(character)
	character._modify_base_stat(StatName.STR, 10)
	print(character)
	(character.character_stats[StatName.DEX] as Stat)._add_modifier(5, ModType.FLAT)
	print(character)
	(character.character_stats[StatName.DEX] as Stat)._add_modifier(5, ModType.MULT)
	print(character)
	(character.character_stats[StatName.DEX] as Stat)._add_modifier(-5, ModType.MULT)
	print(character)
	

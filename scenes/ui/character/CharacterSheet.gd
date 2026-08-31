
class_name CharacterSheet
extends Resource

enum statName{STR,DEX,CON}

var characterStat: Dictionary[statName, int] = {
	statName.STR: 0,
	statName.DEX: 0,
	statName.CON: 0
}


func _increaseStat(key: statName, amount: int):
	if amount > 0:
		characterStat[key] += amount
	else:
		characterStat[key] -= amount

func _initializeSheet(stats: Dictionary[statName, int]):
	for key in stats:
		characterStat[key] = stats[key]
	
	

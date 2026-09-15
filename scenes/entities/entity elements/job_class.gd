extends RefCounted
class_name Job

var jp_gain: Stat = Stat.new(0, GameConstants.StatName.JP_MODIFIERS)
var jp: Stat = Stat.new(0, GameConstants.StatName.JP)
var jp_record: Stat = Stat.new(0, GameConstants.StatName.JP)
var job_name: String
var job_description: String

var abilities: Dictionary[int, Array]




func _init(_abilities: Dictionary[int, Array], _job_name):
	abilities = _abilities
	job_name = _job_name

func _get_ability(key, index):
	return abilities[key][index]

func _get_available_abilities():
	var available_abilities: Array 
	for value: Array in abilities.values():
		for ability: Ability in value:
			if ability.is_ability_unlocked:
				available_abilities.append(value)
	return available_abilities

func _unlock_ability(index: int, job_lvl_key: int):
	var ability_cost = abilities[job_lvl_key][index].ability_jp_cost.final_value
	var current_jp = self.jp.final_value
	if (current_jp >= ability_cost):
		self._spent_jp(ability_cost)
		abilities[job_lvl_key][index].is_ability_unlocked = true
	else:
		print("cannot unlock ability: current jp: %d ability cost: %d " %[current_jp, ability_cost])
	



func _to_string() -> String:

	return "Job: %s | JP: %s | JP Record : %s | Abilità: %s" % [
		job_name,
		jp.to_string(),      # Sfrutta il to_string() della classe Stat
		jp_record.to_string(), # Sfrutta il to_string() della classe Stat
		abilities
	]
	
func _gain_jp(amount: int):
	jp_gain.base_value = 0
	jp_gain._increment_base_value(amount)
	var gained_jp = jp_gain.final_value
	jp._increment_base_value(gained_jp)
	jp_record._increment_base_value(gained_jp)
	

func _spent_jp(amount: int):
	jp_gain.base_value = 0
	jp_gain._increment_base_value(amount)
	var spent_jp = (jp_gain.final_value) * -1
	jp._increment_base_value(spent_jp)

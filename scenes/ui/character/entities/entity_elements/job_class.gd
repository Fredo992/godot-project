extends RefCounted
class_name Job

var jp_gain: Stat = Stat.new(0, GameConstants.StatName.JP_MODIFIERS)
var jp: Stat = Stat.new(0, GameConstants.StatName.JP)
var jp_record: Stat = Stat.new(0, GameConstants.StatName.JP)
var job_name: String
var job_description: String

var abilities: Array[Ability]

func _init(_abilities: Array[Ability], _job_name):
	abilities = _abilities
	job_name = _job_name

func _get_available_abilities():
	var available_abilities: Array 
	for ability: Ability in abilities:
		if ability.is_ability_unlocked:
			available_abilities.append(ability)
	return available_abilities


func _to_string() -> String:
	var abilities_summary = []
	for ability in abilities:
		abilities_summary.append(str(ability))
	
	return "Job: %s | JP Spendibili: %s | JP Storici (Record): %s | Abilità totali: %d" % [
		job_name,
		jp.to_string(),      # Sfrutta il to_string() della classe Stat
		jp_record.to_string(), # Sfrutta il to_string() della classe Stat
		abilities.size()
	]
	
func _gain_jp(amount: int):
	jp_gain.base_value = 0
	jp_gain._increment_base_value(amount)
	var gained_jp = jp_gain._get_final_value()
	jp._increment_base_value(gained_jp)
	jp_record._increment_base_value(gained_jp)
	

func _spent_jp(amount: int):
	jp_gain.base_value = 0
	jp_gain._increment_base_value(amount)
	var spent_jp = (jp_gain._get_final_value()) * -1
	jp._increment_base_value(spent_jp)

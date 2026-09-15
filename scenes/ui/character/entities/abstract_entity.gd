extends Node
class_name AbstractEntity

var entity_stats: CharacterStat = CharacterStat.new()
var entity_job: Job


func _init(_job: Job = null):
	entity_job = _job


func _to_string() -> String:
	var job_name = entity_job.job_name if entity_job else "No Job"
	return "Entity | Job: %s | Stats: %s" % [job_name, entity_stats]

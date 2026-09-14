extends Job
class_name MageJob

var lvl_one_abilities: Array[Ability] = [
	AbilityBuilder.new().set_name("fireball").set_amount(20).set_target_type(GameConstants.target_type.SINGLE)
	.set_effect(func(x,y,targets: Array[AbstractEntity]): targets[0].entity_stats.character_stats[GameConstants.StatName.HP]._increment_base_value(-y)).build(),
	AbilityBuilder.new().set_name("ice shard").build(),
	AbilityBuilder.new().set_name("thunder").build()
]


func _init():
	self.job_description = "A very squishy ranged caster"
	super(mage_abilities, "Mage")
	
	
var mage_abilities:Dictionary[int, Array] = {
	1:  lvl_one_abilities
}

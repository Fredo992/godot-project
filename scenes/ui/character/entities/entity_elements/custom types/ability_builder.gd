class_name AbilityBuilder
extends RefCounted

# Valori di default interni
var _name: String = "Default Ability"
var _description: String = "No description"
var _target_type: GameConstants.target_type = GameConstants.target_type.NONE
var _amount_stat: Stat = Stat.new(0, GameConstants.StatName.AMOUNT)
var _mana_cost_stat: Stat = Stat.new(0, GameConstants.StatName.MANA_COST)
var _jp_cost_stat: Stat = Stat.new(0, GameConstants.StatName.JP_COST)
var _geometry_shape: Vector2 = Vector2.ZERO
var _effect: Callable = func(_tar, _amt, _num): print("No effect")

func set_name(p_name: String) -> AbilityBuilder:
	_name = p_name
	return self

func set_description(p_desc: String) -> AbilityBuilder:
	_description = p_desc
	return self

func set_target_type(p_type: GameConstants.target_type) -> AbilityBuilder:
	_target_type = p_type
	return self

func set_amount(base_val: float, stat_name: GameConstants.StatName = GameConstants.StatName.AMOUNT) -> AbilityBuilder:
	_amount_stat = Stat.new(base_val, stat_name)
	return self

func set_mana_cost(base_val: float) -> AbilityBuilder:
	_mana_cost_stat = Stat.new(base_val, GameConstants.StatName.MANA_COST)
	return self

func set_jp_cost(base_val: float) -> AbilityBuilder:
	_jp_cost_stat = Stat.new(base_val, GameConstants.StatName.JP_COST)
	return self

func set_geometry_shape(p_shape: Vector2) -> AbilityBuilder:
	_geometry_shape = p_shape
	return self

func set_effect(p_effect: Callable) -> AbilityBuilder:
	_effect = p_effect
	return self

func build() -> Ability:
	var ability = Ability.new()
	ability.ability_name = _name
	ability.ability_description = _description
	ability.target_type = _target_type
	ability.amount_value = _amount_stat
	ability.ability_mana_cost = _mana_cost_stat
	ability.ability_jp_cost = _jp_cost_stat
	ability.geometry_shape = _geometry_shape
	ability.to_implement = _effect
	return ability

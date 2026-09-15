extends Stat
class_name DerivedStat

var referred_stat: Stat
var deriving_formula: Callable

func _init(_stat_name: GameConstants.StatName, _referred_stat: Stat, _deriving_formula: Callable):
	referred_stat = _referred_stat
	deriving_formula = _deriving_formula
	super(_deriving_formula.call(_referred_stat.final_value), _stat_name)
	_referred_stat.value_changed.connect(_on_referred_stat_changed)


func _on_referred_stat_changed(new_referred_value: int) -> void:
	base_value = deriving_formula.call(new_referred_value)
	self._get_final_value()

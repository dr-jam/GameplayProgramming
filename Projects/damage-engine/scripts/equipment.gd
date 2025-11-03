extends Resource
class_name Equipment

@export var name: String = "Equipment"
@export var long_range: bool = false
@export var elements: Array[Element.Type] = []
@export var stat_bonus: Dictionary[Stats.Stat, int] = {
	Stats.Stat.STR: 0,
	Stats.Stat.VIT: 0,
	Stats.Stat.AGI: 0,
	Stats.Stat.WIS: 0,
	Stats.Stat.WIL: 0,
	Stats.Stat.ATK: 0,
	Stats.Stat.DEF: 0,
	Stats.Stat.MAG: 0,
	Stats.Stat.MDEF: 0
}

# res://scripts/Stats.gd
extends Resource
class_name Stats

# Enumerated stat keys
enum Stat {
	LEVEL,
	MAX_HP, MAX_MP, HP, MP,
	STR, VIT, AGI, WIS, WIL,
	ATK, DEF, MAG, MDEF
}

# Base values
@export var level: int = 1
@export var max_hp: int = 100
@export var max_mp: int = 20
@export var hp: int = 100
@export var mp: int = 20

@export var strn: int = 10
@export var vit: int = 10
@export var agi: int = 10
@export var wis: int = 10   # replaces int_
@export var wil: int = 10   # replaces spi

@export var atk: int = 10
@export var def_: int = 5
@export var mag: int = 10
@export var mdef: int = 5


# Get stat by enum
func get_stat(stat: Stat) -> int:
	match stat:
		Stat.LEVEL: return level
		Stat.MAX_HP: return max_hp
		Stat.MAX_MP: return max_mp
		Stat.HP: return hp
		Stat.MP: return mp
		Stat.STR: return strn
		Stat.VIT: return vit
		Stat.AGI: return agi
		Stat.WIS: return wis
		Stat.WIL: return wil
		Stat.ATK: return atk
		Stat.DEF: return def_
		Stat.MAG: return mag
		Stat.MDEF: return mdef
		_:
			push_warning("Unknown stat enum id: %s" % str(stat))
			return 0


# Set stat by enum
func set_stat(stat: Stat, value: int) -> void:
	match stat:
		Stat.LEVEL: level = value
		Stat.MAX_HP: max_hp = value
		Stat.MAX_MP: max_mp = value
		Stat.HP: hp = value
		Stat.MP: mp = value
		Stat.STR: strn = value
		Stat.VIT: vit = value
		Stat.AGI: agi = value
		Stat.WIS: wis = value
		Stat.WIL: wil = value
		Stat.ATK: atk = value
		Stat.DEF: def_ = value
		Stat.MAG: mag = value
		Stat.MDEF: mdef = value
		_:
			push_warning("Unknown stat enum id: %s" % str(stat))


# Clone
func copy() -> Stats:
	var s := Stats.new()
	for i in Stat.values():
		s.set_stat(i, get_stat(i))
	return s

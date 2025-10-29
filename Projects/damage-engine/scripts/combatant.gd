class_name Combatant
extends Node

const FRONT := 0
const BACK := 1

@export var display_name := "Unit"
@export var row := FRONT

@export var base_stats: Stats
@export var weapon: Equipment
@export var armor: Equipment

# Defender’s per-element tags: { Element.Type.FIRE: "weak"/"resist"/"immune"/"absorb"/"normal" }
@export var element_resist: Dictionary = {}

# Active status flags
var status: Dictionary = {}

func _ready():
	if base_stats == null:
		base_stats = Stats.new()
	for k in StatusEffects.KEYS.keys():
		status[k] = StatusEffects.KEYS[k]

func total_stats() -> Stats:
	var s := base_stats.copy()
	if weapon:
		for k in weapon.stat_bonus.keys():
			var key = (k == "def") if "def" else k
			s.set_stat(key, s.get_stat(key) + int(weapon.stat_bonus[k]))
	if armor:
		for k in armor.stat_bonus.keys():
			var key = (k == "def") if "def" else k
			s.set_stat(key, s.get_stat(key) + int(armor.stat_bonus[k]))
	return s

func weapon_elements() -> Array:
	return Element.combine(weapon.elements) if weapon and weapon.elements.size() > 0 else []

func is_long_range_weapon() -> bool:
	return weapon != null and weapon.long_range

func is_alive() -> bool:
	return base_stats.hp > 0

func take_damage(n: int) -> void:
	base_stats.hp = max(0, base_stats.hp - n)

func heal(n: int) -> void:
	base_stats.hp = min(base_stats.max_hp, base_stats.hp + n)

func set_status_flag(k: String, v: bool) -> void:
	status[k] = v

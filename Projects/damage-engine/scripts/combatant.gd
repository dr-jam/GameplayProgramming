class_name Combatant
extends Node

const FRONT := 0
const BACK := 1

@export var display_name := "Unit"
@export var row := FRONT

@export var base_stats: Stats
@export var weapon: Equipment
@export var armor: Equipment

# Defender’s per-element tags using Element.ResistTag
# Example: { Element.Type.FIRE: Element.ResistTag.WEAK }
@export var element_resist: Dictionary[Element.Type, Element.ResistTag] = {}

# Active status flags
var status: Dictionary[StatusEffects.Status, bool] = {}

func _ready():
	if base_stats == null:
		base_stats = Stats.new()
	for k in StatusEffects.KEYS.keys():
		status[k] = StatusEffects.KEYS[k]

func total_stats() -> Stats:
	var s := base_stats.copy()
	if weapon:
		for k in weapon.stat_bonus.keys():
			# k is a Stats.Stat enum value
			s.set_stat(k, s.get_stat(k) + int(weapon.stat_bonus[k]))
	if armor:
		for k in armor.stat_bonus.keys():
			# k is a Stats.Stat enum value
			s.set_stat(k, s.get_stat(k) + int(armor.stat_bonus[k]))
	return s

func weapon_elements() -> Array[Element.Type]:
	if weapon and weapon.elements.size() > 0:
		return Element.combine(weapon.elements)
	else:
		return []

func is_long_range_weapon() -> bool:
	return weapon != null and weapon.long_range

func is_alive() -> bool:
	return base_stats.hp > 0

func take_damage(n: int) -> void:
	base_stats.hp = max(0, base_stats.hp - n)

func heal(n: int) -> void:
	base_stats.hp = min(base_stats.max_hp, base_stats.hp + n)

func set_status_flag(k: StatusEffects.Status, v: bool) -> void:
	status[k] = v

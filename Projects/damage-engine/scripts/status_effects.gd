class_name StatusEffects
extends Resource

# Enumerated status flags
enum Status { DEFENDING, PROTECT, SHELL, BLIND, BERSERK, POISON }

const DefaultStatusRules = preload("res://scripts/status_rules.gd")

const KEYS: Dictionary[Status, bool] = {
	Status.DEFENDING: false, # Defend command (halves incoming)
	Status.PROTECT: false,   # Physical incoming halved
	Status.SHELL: false,     # Magical incoming halved
	Status.BLIND: false,     # Physical output penalty, also affects hit chance
	Status.BERSERK: false,   # Physical output bonus
	Status.POISON: false
}

# Rules resource allows designers to tweak multipliers without code changes
static var RULES: StatusRules = StatusRules.new()


static func set_rules(rules: StatusRules) -> void:
	RULES = rules


static func has(status_flags: Dictionary[Status, bool], status_key: Status) -> bool:
	return status_flags.get(status_key, false)


static func physical_out_mult(status_flags: Dictionary[Status, bool], rules: StatusRules = RULES) -> float:
	var m := 1.0
	if has(status_flags, Status.BERSERK): m *= rules.berserk_out_mult
	if has(status_flags, Status.BLIND):   m *= rules.blind_out_mult
	return m


static func physical_in_mult(status_flags: Dictionary[Status, bool], rules: StatusRules = RULES) -> float:
	var m := 1.0
	if has(status_flags, Status.PROTECT):   m *= rules.protect_in_mult
	if has(status_flags, Status.DEFENDING): m *= rules.defending_in_mult
	return m


static func magical_in_mult(status_flags: Dictionary[Status, bool], rules: StatusRules = RULES) -> float:
	var m := 1.0
	if has(status_flags, Status.SHELL): m *= rules.shell_in_mult
	return m

class_name StatusEffects
extends Resource
const DefaultStatusRules = preload("res://scripts/status_rules.gd")

# Enumerated status flags
enum Status { DEFENDING, PROTECT, SHELL, BLIND, BERSERK, POISON }

# Rules resource allows designers to tweak multipliers without code changes
static var RULES: StatusRules = StatusRules.new()

static func set_rules(rules: StatusRules) -> void:
	RULES = rules

const KEYS: Dictionary[Status, bool] = {
	Status.DEFENDING: false, # Defend command (halves incoming)
	Status.PROTECT: false,   # Physical incoming halved
	Status.SHELL: false,     # Magical incoming halved
	Status.BLIND: false,     # Physical output penalty, also affects hit chance
	Status.BERSERK: false,   # Physical output bonus
	Status.POISON: false
}

static func has(s: Dictionary[Status, bool], k: Status) -> bool:
	return bool(s.get(k, false))

static func physical_out_mult(s: Dictionary[Status, bool], rules: StatusRules = RULES) -> float:
	var m := 1.0
	if has(s, Status.BERSERK): m *= rules.berserk_out_mult
	if has(s, Status.BLIND):   m *= rules.blind_out_mult
	return m

static func physical_in_mult(s: Dictionary[Status, bool], rules: StatusRules = RULES) -> float:
	var m := 1.0
	if has(s, Status.PROTECT):   m *= rules.protect_in_mult
	if has(s, Status.DEFENDING): m *= rules.defending_in_mult
	return m

static func magical_in_mult(s: Dictionary[Status, bool], rules: StatusRules = RULES) -> float:
	var m := 1.0
	if has(s, Status.SHELL): m *= rules.shell_in_mult
	return m

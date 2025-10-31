class_name StatusEffects
extends Resource

# Enumerated status flags
enum Status { DEFENDING, PROTECT, SHELL, BLIND, BERSERK, POISON }

# Default boolean flags keyed by Status enum
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

static func physical_out_mult(s: Dictionary[Status, bool]) -> float:
	var m := 1.0
	if has(s, Status.BERSERK): m *= 1.5
	if has(s, Status.BLIND):   m *= 0.75
	return m

static func physical_in_mult(s: Dictionary[Status, bool]) -> float:
	var m := 1.0
	if has(s, Status.PROTECT):   m *= 0.5
	if has(s, Status.DEFENDING): m *= 0.5
	return m

static func magical_in_mult(s: Dictionary[Status, bool]) -> float:
	var m := 1.0
	if has(s, Status.SHELL): m *= 0.5
	return m

class_name StatusEffects
extends Resource


# Boolean flags
const KEYS := {
	"defending": false, # Defend command (halves incoming)
	"protect": false,   # Physical incoming halved
	"shell": false,     # Magical incoming halved
	"blind": false,     # We’ll model as physical output penalty
	"berserk": false,   # Physical output bonus
	"poison": false
}

static func has(s: Dictionary, k: String) -> bool:
	return bool(s.get(k, false))


static func physical_out_mult(s: Dictionary) -> float:
	var m := 1.0
	if has(s, "berserk"): m *= 1.5
	if has(s, "blind"):   m *= 0.75
	return m


static func physical_in_mult(s: Dictionary) -> float:
	var m := 1.0
	if has(s, "protect"):  m *= 0.5
	if has(s, "defending"): m *= 0.5
	return m


static func magical_in_mult(s: Dictionary) -> float:
	var m := 1.0
	if has(s, "shell"): m *= 0.5
	return m

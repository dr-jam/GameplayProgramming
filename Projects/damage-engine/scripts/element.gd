class_name Element
extends Resource

enum Type { NONE, FIRE, ICE, LIGHTNING, HOLY, DARK, POISON }

# Defender resist tags
#  normal  = 1.0
#  weak    = 1.5
#  resist  = 0.5
#  immune  = 0.0
#  absorb  = -1.0 (heals)
const MULT := {
	"normal": 1.0,
	"weak": 1.5,
	"resist": 0.5,
	"immune": 0.0,
	"absorb": -1.0
}

static func combine(elems: Array[Element.Type]) -> Array[Element.Type]:
	var out: Array[Element.Type] = []
	for e in elems:
		if e != Type.NONE and not out.has(e):
			out.append(e)
	return out

static func vs_defender(attacker_elems: Array[Element.Type], defender_resist: Dictionary[Element.Type, String]) -> float:
	if attacker_elems.is_empty(): return 1.0
	var m := 1.0
	for e in attacker_elems:
		var tag := str(defender_resist.get(e, "normal"))
		m *= float(MULT.get(tag, 1.0))
	return m

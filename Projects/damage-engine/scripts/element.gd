class_name Element
extends Resource

enum Type { NONE, FIRE, ICE, LIGHTNING, HOLY, DARK, POISON }

# Enumerated defender resistance tag
enum ResistTag { NORMAL, WEAK, RESIST, IMMUNE, ABSORB }

# Defender resist multipliers by tag
#  NORMAL:  1.0
#  WEAK:    1.5
#  RESIST:  0.5
#  IMMUNE:  0.0
#  ABSORB: -1.0 (heals)
const MULT: Dictionary[ResistTag, float] = {
	ResistTag.NORMAL: 1.0,
	ResistTag.WEAK: 1.5,
	ResistTag.RESIST: 0.5,
	ResistTag.IMMUNE: 0.0,
	ResistTag.ABSORB: -1.0
}

static func combine(elems: Array[Element.Type]) -> Array[Element.Type]:
	var out: Array[Element.Type] = []
	for e in elems:
		if e != Type.NONE and not out.has(e):
			out.append(e)
	return out

static func vs_defender(attacker_elems: Array[Element.Type], defender_resist: Dictionary[Element.Type, ResistTag]) -> float:
	if attacker_elems.is_empty():
		return 1.0
	var m := 1.0
	for e in attacker_elems:
		var tag: ResistTag = defender_resist.get(e, ResistTag.NORMAL)
		m *= float(MULT.get(tag, 1.0))
	return m

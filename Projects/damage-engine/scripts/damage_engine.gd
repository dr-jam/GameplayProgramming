extends Node
class_name FF4DamageEngine

const CRIT_BASE := 0.03
const CRIT_AGI_SCALE := 0.0015
const CRIT_MULT := 1.5
const VARIANCE_LOW := 0.93
const VARIANCE_HIGH := 1.07
const DAMAGE_CAP := 9999       

const HIT_BASE := 0.90                 
const HIT_AGI_DIFF_SCALE := 0.003      
const HIT_MIN := 0.05                  
const HIT_MAX := 0.99                  
const BLIND_HIT_MULT := 0.5

const BACKROW_OUT := 0.5
const BACKROW_IN  := 0.5


static func _rand_range(min_val: float, max_val: float) -> float:
	return min_val + randf() * (max_val - min_val)


static func _roll_crit(agi: int) -> bool:
	return randf() < (CRIT_BASE + float(agi) * CRIT_AGI_SCALE)


static func _element_mult(attacker_elems: Array[Element.Type], defender_resist: Dictionary[Element.Type, Element.ResistTag]) -> float:
	return Element.vs_defender(attacker_elems, defender_resist)


static func _row_mult(attacker: Combatant, defender: Combatant) -> float:
	var m := 1.0
	if attacker.row == Combatant.BACK and not attacker.is_long_range_weapon():
		m *= BACKROW_OUT
	if defender.row == Combatant.BACK:
		m *= BACKROW_IN
	return m


static func _roll_phys_hit(attacker: Combatant, defender: Combatant) -> bool:
	var A := attacker.total_stats()
	var D := defender.total_stats()
	var chance := HIT_BASE + float(A.agi - D.agi) * HIT_AGI_DIFF_SCALE
	if StatusEffects.has(attacker.status, StatusEffects.Status.BLIND):
		chance *= BLIND_HIT_MULT
	chance = clamp(chance, HIT_MIN, HIT_MAX)
	return randf() < chance


static func physical_damage(attacker: Combatant, defender: Combatant) -> CombatResult:
	if not _roll_phys_hit(attacker, defender):
		var elems_miss := attacker.weapon_elements()
		return CombatResult.new(0, false, false, elems_miss, false)

	var att_stats := attacker.total_stats()
	var def_stats := defender.total_stats()

	var attack_raw := att_stats.atk + int(floor(att_stats.strn / 2.0))
	var defense_raw := def_stats.def + int(floor(def_stats.vit / 2.0))

	var crit := _roll_crit(att_stats.agi)
	var def_factor : float
	if crit:
		def_factor = 0.25
	else:
		def_factor = 0.50
	var base : int = max(1, attack_raw - int(floor(defense_raw * def_factor)))

	base = int(round(base * _rand_range(VARIANCE_LOW, VARIANCE_HIGH)))

	if crit:
		base = int(round(base * CRIT_MULT))

	base = int(round(base * StatusEffects.physical_out_mult(attacker.status)))
	base = int(round(base * StatusEffects.physical_in_mult(defender.status)))

	base = int(round(base * _row_mult(attacker, defender)))

	var elems := attacker.weapon_elements()
	var em := _element_mult(elems, defender.element_resist)
	base = int(round(base * em))
	var absorbed := (em < 0.0)

	if not absorbed:
		base = clamp(base, 1, DAMAGE_CAP)

	return CombatResult.new(base, crit, absorbed, elems, true)


static func magical_damage(attacker: Combatant, defender: Combatant, power: int, elem: Element.Type) -> CombatResult:
	var att_stats := attacker.total_stats()
	var def_stats := defender.total_stats()

	var magic_raw := power + int(floor(att_stats.wis / 2.0)) + int(floor(att_stats.mag / 2.0))
	var resist_raw := int(floor(def_stats.mdef / 2.0) + floor(def_stats.wil / 2.0))

	var base : int = max(1, magic_raw - resist_raw)
	base = int(round(base * _rand_range(VARIANCE_LOW, VARIANCE_HIGH)))
	base = int(round(base * StatusEffects.magical_in_mult(defender.status)))

	var em := _element_mult([elem], defender.element_resist)
	base = int(round(base * em))
	var absorbed := (em < 0.0)

	if not absorbed:
		base = clamp(base, 1, DAMAGE_CAP)

	return CombatResult.new(base, false, absorbed, [elem])


static func apply_result(defender: Combatant, result: CombatResult) -> void:
	result.apply_to(defender)


class CombatResult:
	var amount: int
	var crit: bool
	var hit: bool
	var absorbed: bool
	var elements: Array  # Array[Element.Type]

	func _init(p_amount: int = 0, p_crit: bool = false, p_absorbed: bool = false, p_elements: Array = [], p_hit: bool = true):
		self.amount = p_amount
		self.crit = p_crit
		self.hit = p_hit
		self.absorbed = p_absorbed
		self.elements = p_elements.duplicate()

	func apply_to(defender: Combatant) -> void:
		if not hit:
			return
		if absorbed:
			defender.heal(abs(amount))
		else:
			defender.take_damage(max(1, amount))

	func pretty_str() -> String:
		return "{amount:%d, hit:%s, crit:%s, absorbed:%s, elements:%s}" % [amount, str(hit), str(crit), str(absorbed), str(elements)]
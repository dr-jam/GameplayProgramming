# res://scripts/DamageEngine.gd
extends Node
class_name FF4DamageEngine

# ---------- Inner result type ----------
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

# ---------- Tunables ----------
const CRIT_BASE := 0.03          # base crit chance (no LUK)
const CRIT_AGI_SCALE := 0.0015   # +0.15% crit per AGI
const CRIT_MULT := 1.5
const VARIANCE_LOW := 0.93
const VARIANCE_HIGH := 1.07
const DAMAGE_CAP := 9999       # maximum non-absorbed damage dealt

# Hit/Evasion (physical only)
const HIT_BASE := 0.90                 # base 90% hit chance
const HIT_AGI_DIFF_SCALE := 0.003      # ±0.3% per AGI difference (attacker - defender)
const HIT_MIN := 0.05                  # never below 5%
const HIT_MAX := 0.99                  # never above 99%
const BLIND_HIT_MULT := 0.5            # blind halves hit chance

# Rows (physical only)
const BACKROW_OUT := 0.5   # attacker in back (non long-range) halves output
const BACKROW_IN  := 0.5   # defender in back halves incoming

# ---------- Helpers ----------
static func _rand_range(a: float, b: float) -> float:
	return a + randf() * (b - a)

static func _roll_crit(agi: int) -> bool:
	return randf() < (CRIT_BASE + float(agi) * CRIT_AGI_SCALE)

static func _element_mult(attacker_elems: Array, defender_resist: Dictionary) -> float:
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
	if StatusEffects.has(attacker.status, "blind"):
		chance *= BLIND_HIT_MULT
	chance = clamp(chance, HIT_MIN, HIT_MAX)
	return randf() < chance

# ---------- Physical damage ----------
static func physical_damage(attacker: Combatant, defender: Combatant) -> CombatResult:
	# Roll hit/evasion first
	if not _roll_phys_hit(attacker, defender):
		var elems_miss := attacker.weapon_elements()
		return CombatResult.new(0, false, false, elems_miss, false)

	var A := attacker.total_stats()
	var D := defender.total_stats()

	var atk_term := A.atk + int(floor(A.strn / 2.0))
	var def_term := D.def_ + int(floor(D.vit / 2.0))

	var crit := _roll_crit(A.agi)
	var def_factor : float
	if crit:
		def_factor = 0.25
	else:
		def_factor = 0.50
	var base : int = max(1, atk_term - int(floor(def_term * def_factor)))

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

# ---------- Magical damage (single-element) ----------
# Uses WIS for offense, WIL for resistance.
static func magical_damage(attacker: Combatant, defender: Combatant, power: int, elem: Element.Type) -> CombatResult:
	var A := attacker.total_stats()
	var D := defender.total_stats()

	var mag_term := power + int(floor(A.wis / 2.0)) + int(floor(A.mag / 2.0))
	var mres := int(floor(D.mdef / 2.0) + floor(D.wil / 2.0))

	var base : int = max(1, mag_term - mres)
	base = int(round(base * _rand_range(VARIANCE_LOW, VARIANCE_HIGH)))
	base = int(round(base * StatusEffects.magical_in_mult(defender.status)))

	var em := _element_mult([elem], defender.element_resist)
	base = int(round(base * em))
	var absorbed := (em < 0.0)

	if not absorbed:
		base = clamp(base, 1, DAMAGE_CAP)

	return CombatResult.new(base, false, absorbed, [elem])

# ---------- Optional: keep a static applier for convenience ----------
static func apply_result(defender: Combatant, result: CombatResult) -> void:
	result.apply_to(defender)

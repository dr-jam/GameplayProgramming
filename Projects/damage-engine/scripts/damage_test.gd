extends Node2D

@onready var engine := FF4DamageEngine
@onready var hero: Combatant = $"../Hero"
@onready var foe: Combatant  = $"../Enemy"

func clear_status(u: Combatant) -> void:
	for k in StatusEffects.KEYS.keys():
		u.set_status_flag(k, false)

func demo_phys(label: String) -> void:
	var hp0 := foe.base_stats.hp
	var r := FF4DamageEngine.physical_damage(hero, foe)
	FF4DamageEngine.apply_result(foe, r)
	print(label, " -> ", r.pretty_str(), " (Enemy HP ", hp0, " -> ", foe.base_stats.hp, ")")
	foe.base_stats.hp = hp0

func demo_mag(label: String, power: int, elem: Element.Type) -> void:
	var hp0 := foe.base_stats.hp
	var r := FF4DamageEngine.magical_damage(hero, foe, power, elem)
	r.apply_to(foe)
	print(label, " -> ", r.pretty_str(), " (Enemy HP ", hp0, " -> ", foe.base_stats.hp, ")")
	foe.base_stats.hp = hp0

func _ready():
	randomize()
	# Example enemy resistances
	foe.element_resist = {
		Element.Type.FIRE: Element.ResistTag.WEAK,
		Element.Type.ICE: Element.ResistTag.RESIST,
		Element.Type.HOLY: Element.ResistTag.IMMUNE,
		Element.Type.DARK: Element.ResistTag.ABSORB
	}

	# Baseline (no statuses)
	clear_status(hero)
	clear_status(foe)
	demo_phys("Phys baseline")
	demo_mag("Fire baseline", 30, Element.Type.FIRE)

	# Defender has Protect (physical incoming halved)
	clear_status(hero)
	clear_status(foe)
	foe.set_status_flag(StatusEffects.Status.PROTECT, true)
	demo_phys("Phys vs PROTECT")

	# Defender is Defending (halves incoming physical)
	clear_status(hero)
	clear_status(foe)
	foe.set_status_flag(StatusEffects.Status.DEFENDING, true)
	demo_phys("Phys vs DEFENDING")

	# Attacker is Berserk (physical output up)
	clear_status(hero)
	clear_status(foe)
	hero.set_status_flag(StatusEffects.Status.BERSERK, true)
	demo_phys("Phys with BERSERK")

	# Attacker is Blind (physical output down and lower hit chance; may miss)
	clear_status(hero)
	clear_status(foe)
	hero.set_status_flag(StatusEffects.Status.BLIND, true)
	for i in 3:
		demo_phys("Phys with BLIND (try %d)" % (i + 1))

	# Defender has Shell (magical incoming halved)
	clear_status(hero)
	clear_status(foe)
	foe.set_status_flag(StatusEffects.Status.SHELL, true)
	demo_mag("Fire vs SHELL", 30, Element.Type.FIRE)

	# Magical absorb example (Dark is absorbed per resist table above)
	clear_status(hero)
	clear_status(foe)
	demo_mag("Dark absorb", 30, Element.Type.DARK)

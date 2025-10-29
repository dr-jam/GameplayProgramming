extends Node2D

@onready var engine := FF4DamageEngine
@onready var hero: Combatant = $"../Hero"
@onready var foe: Combatant  = $"../Enemy"

func _ready():
	randomize()
	# Example enemy resistances
	foe.element_resist = {
		Element.Type.FIRE: "weak",
		Element.Type.ICE: "resist",
		Element.Type.HOLY: "immune",
		Element.Type.DARK: "absorb"
	}

	# Physical attack
	var r1 : FF4DamageEngine.CombatResult = FF4DamageEngine.physical_damage(hero, foe)
	FF4DamageEngine.apply_result(foe, r1)
	print("Phys -> ", r1.pretty_str())

	var r2: FF4DamageEngine.CombatResult = FF4DamageEngine.magical_damage(hero, foe, 30, Element.Type.FIRE)
	r2.apply_to(foe)  # instance method also available
	print("Fire -> ", r2.pretty_str())

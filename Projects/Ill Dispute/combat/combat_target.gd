class_name CombatTarget
extends Node2D
## Shared faction and health contract for units and forts.

signal health_changed(target: CombatTarget)
signal defeated(target: CombatTarget)

enum Faction { HUMANS, ORCS }

var team: Faction = Faction.HUMANS
var max_health := 1.0
var health := max_health


func configure_target(faction: Faction, starting_health: float) -> void:
	team = faction
	max_health = starting_health
	health = max_health
	add_to_group("combat_targets")


func take_damage(amount: float) -> void:
	if amount <= 0.0:
		push_warning("Damage must be greater than zero.")
		return
	if health <= 0.0:
		return

	health = maxf(0.0, health - amount)
	health_changed.emit(self)
	if health == 0.0:
		defeated.emit(self)

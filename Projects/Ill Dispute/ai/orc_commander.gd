class_name OrcCommander
extends Node
## RTS design goals:
## Keep the lane pressure steady with timed reinforcements, but let orcs peel off
## to nearby human squads before resuming the fort push. This is intentionally
## readable, predictable macro-AI: the commander picks priorities; units fight.

signal request_recruit()

const RECRUIT_INTERVAL := 6.0
const FIRST_RECRUIT_DELAY := 3.0
const THINK_INTERVAL := 1.25
const HUMAN_TARGET_RANGE := 240.0

var active := true
var human_base: Fort
var recruit_timer := FIRST_RECRUIT_DELAY
var think_timer := 0.0


func _process(delta: float) -> void:
	if not active:
		return

	recruit_timer -= delta
	think_timer -= delta

	if recruit_timer <= 0.0:
		recruit_timer = RECRUIT_INTERVAL
		request_recruit.emit()

	if think_timer <= 0.0:
		think_timer = THINK_INTERVAL
		_assign_targets()


func _assign_targets() -> void:
	if not is_instance_valid(human_base):
		return

	var humans: Array[Unit] = []
	for node in get_tree().get_nodes_in_group("humans"):
		var human := node as Unit
		if human != null and human.health > 0.0:
			humans.append(human)

	for node in get_tree().get_nodes_in_group("orcs"):
		var orc := node as Unit
		if orc == null or orc.health <= 0.0:
			continue
		orc.attack(_nearest_target(orc, humans))


func _nearest_target(orc: Unit, humans: Array[Unit]) -> CombatTarget:
	var target: CombatTarget = human_base
	var nearest_distance := orc.position.distance_to(human_base.position)

	# Orcs chase nearby soldiers, but otherwise continue attacking the fort.
	for human in humans:
		var distance := orc.position.distance_to(human.position)
		if distance < nearest_distance and distance < HUMAN_TARGET_RANGE:
			target = human
			nearest_distance = distance

	return target

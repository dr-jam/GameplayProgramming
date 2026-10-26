extends Node2D
## Sets up the match and connects the gameplay systems.
##
## This file coordinates the game. Selection handles player orders, the AI
## chooses targets, and units handle movement and combat.
##
## Start with _ready() as it creates the forts and armies, connects their signals,
## and updates the HUD. During play, _process() adds supply and refreshes the HUD.
##
## The other methods run in response to events. The HUD requests human recruits, the AI
## requests orc recruits, and a destroyed fort ends the match. Restart reloads
## the scene so setup runs again.

const HUMAN := CombatTarget.Faction.HUMANS
const ORC := CombatTarget.Faction.ORCS
const STARTING_UNITS := 5
const RECRUIT_COST := 25
const MAX_SUPPLY := 150.0
const SUPPLY_PER_SECOND := 6.0
const HUD_UPDATE_INTERVAL := 0.25
const SPAWN_HORIZONTAL_OFFSET := 85.0
const SPAWN_ROW_SPACING := 29.0

const UNIT_SCENE: PackedScene = preload("res://units/unit.tscn")
const BASE_SCENE: PackedScene = preload("res://buildings/base.tscn")

@export var movement_bounds: Rect2

var human_base: Fort
var orc_base: Fort
var supply := 65.0
var game_over := false
var recruit_number := 0
var hud_update_timer := 0.0

@onready var actors: Node2D = $Actors
@onready var selection: SelectionController = $Selection
@onready var ai: OrcCommander = $OrcCommander
@onready var hud: GameHUD = $HUD


func _ready() -> void:
	hud.restart_requested.connect(_restart_game)
	human_base = _create_base(HUMAN, Vector2(128, 391))
	orc_base = _create_base(ORC, Vector2(1024, 391))
	if human_base == null or orc_base == null:
		_fail_setup("The game cannot start without both forts.")
		return
	if not _spawn_starting_units():
		_fail_setup("The starting armies could not be created.")
		return

	_connect_features()
	_update_hud()


func _process(delta: float) -> void:
	if game_over:
		return

	supply = minf(MAX_SUPPLY, supply + SUPPLY_PER_SECOND * delta)
	hud_update_timer -= delta
	if hud_update_timer <= 0.0:
		hud_update_timer = HUD_UPDATE_INTERVAL
		_update_hud()


func _spawn_starting_units() -> bool:
	for index in range(STARTING_UNITS):
		var y_position := 270 + index * 55
		var human_x := 216 + (index % 2) * 33
		var orc_x := 936 - (index % 2) * 33
		if _create_unit(HUMAN, Vector2(human_x, y_position)) == null:
			return false
		if _create_unit(ORC, Vector2(orc_x, y_position)) == null:
			return false
	return true


## The AI needs the human fort, so we assign it here. This is property injection.
## The AI gets a reference without needing to know where the fort is in the tree.
func _connect_features() -> void:
	ai.human_base = human_base
	ai.request_recruit.connect(_recruit_orc)
	hud.recruit_requested.connect(_recruit_human)


func _create_base(team: CombatTarget.Faction, location: Vector2) -> Fort:
	var instance := BASE_SCENE.instantiate()
	if not instance is Fort:
		instance.free()
		push_error("Base scene must have the Fort script.")
		return null

	var base: Fort = instance
	if not base.configure(team, location):
		base.free()
		return null
	actors.add_child(base)
	base.destroyed.connect(_on_base_destroyed)
	return base


func _create_unit(team: CombatTarget.Faction, location: Vector2) -> Unit:
	var instance := UNIT_SCENE.instantiate()
	if not instance is Unit:
		instance.free()
		push_error("Unit scene must have the Unit script.")
		return null

	var unit: Unit = instance
	if not unit.configure(team, location, movement_bounds):
		unit.free()
		return null
	actors.add_child(unit)
	return unit


func _recruit_human() -> void:
	if game_over or supply < RECRUIT_COST or not is_instance_valid(human_base):
		return

	var spawn_position := _next_spawn_position(human_base, SPAWN_HORIZONTAL_OFFSET)
	var unit := _create_unit(HUMAN, spawn_position)
	if unit == null:
		return
	supply -= RECRUIT_COST
	unit.move_to(Vector2(385, spawn_position.y))
	_update_hud()


func _recruit_orc() -> void:
	if game_over or not is_instance_valid(orc_base):
		return

	var spawn_position := _next_spawn_position(orc_base, -SPAWN_HORIZONTAL_OFFSET)
	var unit := _create_unit(ORC, spawn_position)
	if unit == null:
		return
	if is_instance_valid(human_base):
		unit.attack(human_base)


func _next_spawn_position(base: Fort, horizontal_offset: float) -> Vector2:
	recruit_number += 1
	var vertical_offset := float((recruit_number % 5) - 2) * SPAWN_ROW_SPACING
	return base.position + Vector2(horizontal_offset, vertical_offset)


func _on_base_destroyed(team: CombatTarget.Faction) -> void:
	if game_over:
		return

	_stop_simulation()
	_update_hud()
	var result := "ORCS WIN"
	if team == ORC:
		result = "HUMANS WIN"
	hud.show_result(result)


## Stop the world, not the whole tree, so the HUD's restart button still works.
func _stop_simulation() -> void:
	game_over = true
	set_process(false)
	ai.active = false
	selection.enabled = false
	selection.clear()
	actors.process_mode = Node.PROCESS_MODE_DISABLED


func _fail_setup(message: String) -> void:
	push_error(message)
	_stop_simulation()
	hud.show_result("MATCH SETUP FAILED")


func _restart_game() -> void:
	var error := get_tree().reload_current_scene()
	if error != OK:
		push_error("Could not restart the match. Error %d." % error)


func _update_hud() -> void:
	var human_health := 0
	var orc_health := 0
	if is_instance_valid(human_base):
		human_health = roundi(human_base.health)
	if is_instance_valid(orc_base):
		orc_health = roundi(orc_base.health)
	var human_count := get_tree().get_nodes_in_group("humans").size()
	var orc_count := get_tree().get_nodes_in_group("orcs").size()

	hud.update_state(
		floori(supply),
		human_health,
		orc_health,
		human_count,
		orc_count,
		RECRUIT_COST
	)

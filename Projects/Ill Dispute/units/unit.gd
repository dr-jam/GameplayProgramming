class_name Unit
extends CombatTarget
## Self-contained combatant. Movement, health and attack live with the unit.
## External code issues orders; the unit does not know about the HUD or commander.

const HUMAN_MAX_HEALTH := 75.0
const ORC_MAX_HEALTH := 85.0
const HUMAN_SPEED := 88.0
const ORC_SPEED := 76.0
const HUMAN_DAMAGE := 11.0
const ORC_DAMAGE := 12.0
const HUMAN_ATTACK_COOLDOWN := 0.75
const ORC_ATTACK_COOLDOWN := 0.9
const DETECTION_RANGE := 115.0
const ARRIVAL_DISTANCE := 5.0
const MIN_POSITION := Vector2(45.0, 113.0)
const MAX_POSITION := Vector2(1104.0, 662.0)

@onready var human_visuals: Node2D = $HumanVisuals
@onready var orc_visuals: Node2D = $OrcVisuals
@onready var health_fill: Polygon2D = $HealthBar/Fill
@onready var selection_ring: Line2D = $SelectionRing

var selected := false:
	set(value):
		selected = value
		if is_node_ready():
			selection_ring.visible = value
var speed := HUMAN_SPEED
var damage := HUMAN_DAMAGE
var attack_range := 32.0
var attack_cooldown := HUMAN_ATTACK_COOLDOWN
var attack_timer := 0.0
var destination: Vector2
var target: CombatTarget
var holding := false


func _ready() -> void:
	health_changed.connect(_update_health_bar)
	defeated.connect(_on_defeated)


func configure(faction: Faction, location: Vector2) -> void:
	var starting_health := HUMAN_MAX_HEALTH
	speed = HUMAN_SPEED
	damage = HUMAN_DAMAGE
	attack_cooldown = HUMAN_ATTACK_COOLDOWN
	if faction == Faction.ORCS:
		starting_health = ORC_MAX_HEALTH
		speed = ORC_SPEED
		damage = ORC_DAMAGE
		attack_cooldown = ORC_ATTACK_COOLDOWN

	configure_target(faction, starting_health)
	position = location
	destination = location
	human_visuals.visible = team == Faction.HUMANS
	orc_visuals.visible = team == Faction.ORCS
	add_to_group("combatants")
	if team == Faction.HUMANS:
		add_to_group("humans")
	else:
		add_to_group("orcs")
	_update_health_bar(self)


func move_to(point: Vector2) -> void:
	target = null
	holding = false
	destination = Vector2(
		clampf(point.x, MIN_POSITION.x, MAX_POSITION.x),
		clampf(point.y, MIN_POSITION.y, MAX_POSITION.y)
	)


func attack(enemy: CombatTarget) -> void:
	if not is_instance_valid(enemy) or enemy == self or enemy.health <= 0.0:
		return
	target = enemy
	holding = false


func hold() -> void:
	target = null
	holding = true
	destination = position


func _physics_process(delta: float) -> void:
	if health <= 0.0:
		return
	attack_timer = maxf(0.0, attack_timer - delta)
	if is_instance_valid(target) and target.health > 0.0:
		var reach := attack_range
		if target.is_in_group("bases"):
			reach += 25.0
		if position.distance_to(target.position) <= reach:
			_hit_target()
		elif not holding:
			_advance(target.position, delta)
	else:
		target = null
		if not holding:
			_acquire_enemy()
			if target == null and position.distance_to(destination) > ARRIVAL_DISTANCE:
				_advance(destination, delta)


func _advance(point: Vector2, delta: float) -> void:
	var displacement := point - position
	if displacement.length() < 2.0:
		return
	var next := position + displacement.normalized() * minf(displacement.length(), speed * delta)
	position = Vector2(
		clampf(next.x, MIN_POSITION.x, MAX_POSITION.x),
		clampf(next.y, MIN_POSITION.y, MAX_POSITION.y)
	)


func _acquire_enemy() -> void:
	var nearest_enemy: CombatTarget
	var nearest_distance := DETECTION_RANGE
	for node in get_tree().get_nodes_in_group("combat_targets"):
		var candidate := node as CombatTarget
		if candidate == null or candidate == self:
			continue
		if candidate.team == team or candidate.health <= 0.0:
			continue
		var distance := position.distance_to(candidate.position)
		if distance < nearest_distance:
			nearest_enemy = candidate
			nearest_distance = distance
	target = nearest_enemy


func _hit_target() -> void:
	if attack_timer > 0.0:
		return
	if is_instance_valid(target):
		target.take_damage(damage)
		attack_timer = attack_cooldown


func _update_health_bar(_target: CombatTarget) -> void:
	health_fill.scale.x = health / max_health


func _on_defeated(_target: CombatTarget) -> void:
	queue_free()

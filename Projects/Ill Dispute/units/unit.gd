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
const DETECTION_INTERVAL := 0.25
const ARRIVAL_DISTANCE := 5.0
const FORT_REACH_BONUS := 25.0

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
var movement_bounds: Rect2
var configured := false
var detection_timer := 0.0

@onready var human_visuals: Node2D = $HumanVisuals
@onready var orc_visuals: Node2D = $OrcVisuals
@onready var health_fill: Polygon2D = $HealthBar/Fill
@onready var selection_ring: Line2D = $SelectionRing
@onready var attack_animation: AnimationPlayer = $AttackAnimation
@onready var damage_animation: AnimationPlayer = $DamageAnimation


func _ready() -> void:
	# Animation players run independently so effects can finish after the match stops.
	health_changed.connect(_update_health_bar)
	health_changed.connect(_flash_damage)
	defeated.connect(_on_defeated)
	_update_visuals()
	set_physics_process(configured)


## Setup can run before or after add_child(). Visuals wait until the nodes are ready.
func configure(faction: Faction, location: Vector2, bounds: Rect2) -> bool:
	if bounds.size.x <= 0.0 or bounds.size.y <= 0.0:
		push_error("Unit movement bounds must have a positive width and height.")
		return false

	var starting_health := HUMAN_MAX_HEALTH
	speed = HUMAN_SPEED
	damage = HUMAN_DAMAGE
	attack_cooldown = HUMAN_ATTACK_COOLDOWN
	if faction == Faction.ORCS:
		starting_health = ORC_MAX_HEALTH
		speed = ORC_SPEED
		damage = ORC_DAMAGE
		attack_cooldown = ORC_ATTACK_COOLDOWN

	if not configure_target(faction, starting_health):
		return false

	movement_bounds = bounds
	position = location
	destination = location
	target = null
	holding = false
	attack_timer = 0.0
	detection_timer = 0.0
	configured = true
	add_to_group("combatants")
	remove_from_group("humans")
	remove_from_group("orcs")
	if team == Faction.HUMANS:
		add_to_group("humans")
	else:
		add_to_group("orcs")

	if is_node_ready():
		attack_animation.stop()
		damage_animation.stop()
		_update_visuals()
		set_physics_process(true)
	return true


func move_to(point: Vector2) -> void:
	target = null
	holding = false
	destination = Vector2(
		clampf(point.x, movement_bounds.position.x, movement_bounds.end.x),
		clampf(point.y, movement_bounds.position.y, movement_bounds.end.y)
	)


func attack(enemy: CombatTarget) -> void:
	if not is_instance_valid(enemy) or enemy == self or enemy.health <= 0.0:
		return
	if enemy.team == team:
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
	detection_timer = maxf(0.0, detection_timer - delta)
	if is_instance_valid(target) and target.health > 0.0:
		var reach := attack_range
		if target.is_in_group("bases"):
			reach += FORT_REACH_BONUS
		if position.distance_to(target.position) <= reach:
			_hit_target()
		elif not holding:
			_advance(target.position, delta)
	else:
		target = null
		if not holding:
			# Idle troops check periodically instead of scanning every physics tick.
			if detection_timer == 0.0:
				_acquire_enemy()
				detection_timer = DETECTION_INTERVAL
			if target == null and position.distance_to(destination) > ARRIVAL_DISTANCE:
				_advance(destination, delta)


func _advance(point: Vector2, delta: float) -> void:
	var displacement := point - position
	if displacement.length() < 2.0:
		return
	var next := position + displacement.normalized() * minf(displacement.length(), speed * delta)
	position = Vector2(
		clampf(next.x, movement_bounds.position.x, movement_bounds.end.x),
		clampf(next.y, movement_bounds.position.y, movement_bounds.end.y)
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
	if is_instance_valid(target) and target.health > 0.0:
		# The swing crosses the local right axis. Turn the model toward its opponent.
		var facing := (target.position - position).angle()
		human_visuals.rotation = facing
		orc_visuals.rotation = facing
		target.take_damage(damage)
		attack_timer = attack_cooldown
		# Damage is immediate. The swing only shows that the hit happened.
		attack_animation.play("swing")


func _update_health_bar(_target: CombatTarget) -> void:
	if is_node_ready():
		health_fill.scale.x = health / max_health


func _update_visuals() -> void:
	human_visuals.rotation = 0.0
	orc_visuals.rotation = 0.0
	human_visuals.modulate = Color.WHITE
	orc_visuals.modulate = Color.WHITE
	$HumanVisuals/Sword.rotation = 0.0
	$OrcVisuals/Axe.rotation = 0.0
	human_visuals.visible = team == Faction.HUMANS
	orc_visuals.visible = team == Faction.ORCS
	selection_ring.visible = selected
	health_fill.scale.x = health / max_health


func _flash_damage(_target: CombatTarget) -> void:
	if is_node_ready():
		# Stop first so another hit restarts the flash from its first frame.
		damage_animation.stop()
		damage_animation.play("flash")
		damage_animation.advance(0.0)


func _on_defeated(_target: CombatTarget) -> void:
	queue_free()

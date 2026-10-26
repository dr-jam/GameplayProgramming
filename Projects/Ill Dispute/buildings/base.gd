class_name Fort
extends CombatTarget
## Fort health and faction appearance.

signal destroyed(team: Faction)

const MAX_HEALTH := 550.0

@onready var human_visuals: Node2D = $HumanVisuals
@onready var orc_visuals: Node2D = $OrcVisuals
@onready var health_fill: Polygon2D = $HealthBar/Fill

func _ready() -> void:
	health_changed.connect(_update_health_bar)
	defeated.connect(_on_defeated)
	_update_visuals()


func configure(faction: Faction, location: Vector2) -> bool:
	if not configure_target(faction, MAX_HEALTH):
		return false

	position = location
	add_to_group("bases")
	if is_node_ready():
		_update_visuals()
	return true


func _update_health_bar(_target: CombatTarget) -> void:
	if is_node_ready():
		health_fill.scale.x = health / max_health


func _update_visuals() -> void:
	human_visuals.visible = team == Faction.HUMANS
	orc_visuals.visible = team == Faction.ORCS
	health_fill.scale.x = health / max_health


func _on_defeated(_target: CombatTarget) -> void:
	destroyed.emit(team)
	queue_free()

class_name Fort
extends CombatTarget
## Fort health and faction appearance.

signal destroyed(team: int)

@onready var human_visuals: Node2D = $HumanVisuals
@onready var orc_visuals: Node2D = $OrcVisuals
@onready var health_fill: Polygon2D = $HealthBar/Fill

const MAX_HEALTH := 550.0


func _ready() -> void:
	health_changed.connect(_update_health_bar)
	defeated.connect(_on_defeated)
	_update_health_bar(self)


func configure(faction: Faction, location: Vector2) -> void:
	configure_target(faction, MAX_HEALTH)
	position = location
	human_visuals.visible = team == Faction.HUMANS
	orc_visuals.visible = team == Faction.ORCS
	add_to_group("bases")


func _update_health_bar(_target: CombatTarget) -> void:
	health_fill.scale.x = health / max_health


func _on_defeated(_target: CombatTarget) -> void:
	destroyed.emit(team)
	queue_free()

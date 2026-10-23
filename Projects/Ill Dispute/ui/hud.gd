class_name GameHUD
extends CanvasLayer
## HUD is decoupled from gameplay. It receives snapshots and emits user intent.

signal recruit_requested()
signal restart_requested()

@onready var supply_value: Label = $TopPanel/MarginContainer/Content/SupplyCard/Values/Value
@onready var human_value: Label = $TopPanel/MarginContainer/Content/HumanCard/Values/Value
@onready var orc_value: Label = $TopPanel/MarginContainer/Content/OrcCard/Values/Value
@onready var recruit_button: Button = $TopPanel/MarginContainer/Content/RecruitButton
@onready var result_label: Label = $CenterContainer/EndPanel/MarginContainer/Column/ResultLabel
@onready var restart_button: Button = $CenterContainer/EndPanel/MarginContainer/Column/RestartButton
@onready var end_panel: PanelContainer = $CenterContainer/EndPanel


func _ready() -> void:
	recruit_button.pressed.connect(_on_recruit_pressed)
	restart_button.pressed.connect(_on_restart_pressed)


func update_state(
	supply: int,
	human_hp: int,
	orc_hp: int,
	human_count: int,
	orc_count: int,
	cost: int
) -> void:
	supply_value.text = "%d / 150" % supply
	human_value.text = "%d HP   /   %d UNITS" % [human_hp, human_count]
	orc_value.text = "%d HP   /   %d UNITS" % [orc_hp, orc_count]
	recruit_button.disabled = supply < cost


func show_result(message: String) -> void:
	result_label.text = message
	end_panel.visible = true
	recruit_button.disabled = true


func _on_recruit_pressed() -> void:
	recruit_requested.emit()


func _on_restart_pressed() -> void:
	restart_requested.emit()

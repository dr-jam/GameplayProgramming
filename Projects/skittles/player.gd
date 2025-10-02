class_name Player
extends Node3D

@export var projectile_spawn : Node3D 

var _fire1_command : PlayerCommand
var _fire2_command : PlayerCommand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_fire1_command = ShootCommand.new()
	_fire2_command = CollectionNovaCommand.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_pressed("Fire1")):
		var _return_signal = _fire1_command.execute(self)
	if (Input.is_action_pressed("Fire2")):
		var _return_signal = _fire2_command.execute(self)

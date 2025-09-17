class_name CameraController
extends Camera3D

@onready var player:Player = %Player

var _camera_command:CameraCommand

# Called when the node enters the scene tree for the first time.
func _ready():
	_camera_command = RotateAndLookAtCommand.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_camera_command.execute(self, player)

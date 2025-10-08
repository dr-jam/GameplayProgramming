class_name Petal
extends Node2D

signal wind(blowing : bool)

@export var _fall_speed : Vector2 = Vector2(0.0, 10.0)

func _ready() -> void:
	connect("wind", _on_wind)


func _process(delta: float) -> void:
	position += _fall_speed * delta

func _on_wind(blowing:bool) -> void:
	if blowing:
		_fall_speed.x = 10.0
	else:
		_fall_speed.x = 0.0

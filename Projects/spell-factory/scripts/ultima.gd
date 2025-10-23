class_name Ultima
extends Node3D

@export var speed = 5.0

@onready var sprite:Sprite3D = $Sprite3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(transform.basis.y * speed * delta)

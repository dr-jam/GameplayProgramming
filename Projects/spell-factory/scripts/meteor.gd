class_name Meteor
extends Node3D

@export var speed = 5.0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(transform.basis.x * speed * delta)

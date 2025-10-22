class_name PetalManager
extends Node2D


# Finding nodes
@onready var _petal_spawn : Node2D = $PetalSpawn # child shortcut
@onready var _petal1 := get_node("Petal1")  # path lookup


func _ready() -> void:
	# Adding/removing nodes
	var petal_scene: PackedScene = preload("res://Scenes/petal.tscn")
	var petal := petal_scene.instantiate()
	add_child(petal) # parented to 'self'
	# Deferring when necessary (avoid "modified while iterating" errors)
	#call_deferred("add_child", petal)
	petal.global_position = _petal_spawn.global_position
	
	# Groups (tree-wide tagging)
	petal.add_to_group("petals")
	get_tree().get_nodes_in_group("petals")

class_name PoolTag
extends Node
# Attached at runtime under each pooled instance

var factory: Node
var id: StringName

func despawn() -> void:
	if is_instance_valid(factory):
		factory.recycle(id, get_parent())

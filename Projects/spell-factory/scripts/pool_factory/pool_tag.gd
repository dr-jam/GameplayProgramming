class_name PoolTag
extends Node
# Attached at runtime under each pooled instance

var factory: PooledFactory
var id: PooledFactory.Spells

func despawn() -> void:
	if is_instance_valid(factory):
		factory.recycle(id, get_parent())

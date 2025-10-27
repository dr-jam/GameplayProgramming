class_name Pool
extends RefCounted

var _prefab: PackedScene
var _inactive: Array[Node] = []
var _active: Array[Node] = []
var _prewarm: int
var _pool_root: Node  # where pooled nodes live when inactive

func _init(prefab: PackedScene, prewarm: int, pool_root: Node) -> void:
	_prefab = prefab
	_prewarm = max(prewarm, 0)
	_pool_root = pool_root
	_prewarm_nodes()


func _prewarm_nodes() -> void:
	for i in _prewarm:
		var n := _instantiate()
		_idle(n)


func acquire() -> Node:
	if _inactive.is_empty():
		return _mark_active(_instantiate())
	var n := _inactive.pop_back() as Node
	return _mark_active(n)


func recycle(n: Node) -> void:
	if not _active.has(n):
		return
	_active.erase(n)
	_idle(n)


func _instantiate() -> Node:
	var n := _prefab.instantiate()
	return n


func _mark_active(n: Node) -> Node:
	# visible/ready to use; parent is set by the factory caller
	n.set_process(true)
	if n.has_property("visible"):
		n.visible = true
	_active.append(n)
	return n


func _idle(n: Node) -> void:
	# move to pool root, disable processing & hide
	if n.get_parent():
		n.get_parent().remove_child(n)
	_pool_root.add_child(n)
	n.set_process(false)
	if n.has_property("visible"):
		n.visible = false
	_inactive.append(n)

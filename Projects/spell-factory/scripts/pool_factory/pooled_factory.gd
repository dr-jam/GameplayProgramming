class_name PooledFactory
extends Node3D


enum Spells {
	FIREBALL,
	METEOR,
	ULTIMA,
}
# Register your spawnable types here (or expose as exported dictionary).
var _registry: Dictionary[Spells, PackedScene] = {
	Spells.FIREBALL: preload("res://scenes/spells/fireball.tscn"),
	Spells.METEOR: preload("res://scenes/spells/meteor.tscn"),
	Spells.ULTIMA: preload("res://scenes/spells/ultima.tscn"),
}

# Per-ID pool settings (optional; defaults used if missing)
var _settings: Dictionary[Spells, Variant] = {
	Spells.FIREBALL: {"prewarm": 64},
	Spells.METEOR: {"prewarm": 16},
	Spells.ULTIMA: {"prewarm": 8},
}

var _pools: Dictionary = {} # id -> Pool
var _pool_root: Node       # hidden container for inactive nodes

func _ready() -> void:
	_pool_root = Node3D.new()
	_pool_root.name = "PoolRoot"
	_pool_root.visible = false
	add_child(_pool_root)
	_build_pools()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		spawn(Spells.FIREBALL).reparent(owner)
	elif Input.is_action_just_pressed("ui_down"):
		spawn(Spells.METEOR).reparent(owner)
	elif Input.is_action_just_pressed("ui_right"):
		spawn(Spells.ULTIMA).reparent(owner)

func _build_pools() -> void:
	for id: Spells in _registry.keys():
		var prefab: PackedScene = _registry[id]
		var prewarm := int(_settings.get(id, {}).get("prewarm", 0))
		_pools[id] = Pool.new(prefab, prewarm, _pool_root)

# --- PUBLIC API (pool use is transparent) ---

## Spawn an instance by id. Optionally parent it and pass a config dictionary.
func spawn(id: Spells, _config := {}) -> Node:
	var pool: Pool = _pools.get(id)
	if pool == null:
		push_error("PooledFactory: unknown id: %s" % id)
		return null

	var n := pool.acquire()

	# Inject a PoolTag (added once)
	var tag := n.get_node_or_null("PoolTag") as PoolTag
	if tag == null:
		tag = PoolTag.new()
		tag.name = "PoolTag"
		n.add_child(tag)
	tag.factory = self
	tag.id = id

	return n

## Optional: let external scripts explicitly recycle (they don’t have to).
func recycle(id: Spells, node: Node) -> void:
	var pool: Pool = _pools.get(id)
	if pool == null or node == null:
		return

	#node.on_recycled()
	pool.recycle(node)

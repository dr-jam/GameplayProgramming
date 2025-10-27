extends Node
class_name PooledFactory

# Register your spawnable types here (or expose as exported dictionary).
var _registry: Dictionary = {
	"bullet": preload("res://scenes/fireball.tscn"),
	"slime":  preload("res://scenes/meteor.tscn"),
	#"vfx":    preload("res://scenes/ultima.tscn"),
}

# Per-ID pool settings (optional; defaults used if missing)
var _settings: Dictionary = {
	"bullet": {"prewarm": 64},
	"slime":  {"prewarm": 8},
	"vfx":    {"prewarm": 16},
}

var _pools: Dictionary = {} # id -> Pool
var _pool_root: Node       # hidden container for inactive nodes

func _ready() -> void:
	_pool_root = Node3D.new()
	_pool_root.name = "PoolRoot"
	_pool_root.visible = false
	add_child(_pool_root)
	_build_pools()

func _build_pools() -> void:
	for id: StringName in _registry.keys():
		var prefab: PackedScene = _registry[id]
		var prewarm := int(_settings.get(id, {}).get("prewarm", 0))
		_pools[id] = Pool.new(prefab, prewarm, _pool_root)

# --- PUBLIC API (pool use is transparent) ---

## Spawn an instance by id. Optionally parent it and pass a config dictionary.
func spawn(id: StringName, parent: Node = null, config := {}) -> Node:
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

	# Optional product configuration contract
	if "configure" in n:
		n.configure(config)

	# Caller decides parenting; if none provided, keep under factory for convenience
	if parent:
		parent.add_child(n)
	else:
		add_child(n)

	return n

## Optional: let external scripts explicitly recycle (they don’t have to).
func recycle(id: StringName, node: Node) -> void:
	var pool: Pool = _pools.get(id)
	if pool == null or node == null:
		return
	# Allow products to clean up before recycling
	if "on_recycled" in node:
		node.on_recycled()
	pool.recycle(node)

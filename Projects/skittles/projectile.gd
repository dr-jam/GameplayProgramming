class_name Projectile
extends RigidBody3D

@onready var _mesh : MeshInstance3D = $MeshInstance3D

static var projectiles : Array[Projectile]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var material : StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(randf(), randf(), randf())
	_mesh.set_surface_override_material(0, material)
	projectiles.append(self)

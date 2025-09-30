class_name ShootCommand
extends PlayerCommand

@export var _projectile_scene : PackedScene

func execute(player : Player) -> bool:
	var projectile:Projectile = _projectile_scene.instantiate()
	player.add_child(projectile)
	projectile.global_position = player.projectile_spawn.global_position
	projectile.linear_velocity = Vector3(randf_range(5.0, 50.0), randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
	return true

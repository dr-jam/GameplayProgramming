class_name ShootCommand
extends PlayerCommand

var _projectile_scene = preload("res://projectile.tscn")


func execute(player:Player) -> bool:
	var projectile:Projectile = _projectile_scene.instantiate()
	player.add_child(projectile)
	projectile.global_position = player.projectile_spawn.global_position
	projectile.linear_velocity = Vector3(randf_range(5, 50), randf_range(-10, 10), randf_range(-10, 10))
	return true

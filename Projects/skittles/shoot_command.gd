class_name ShootCommand
extends PlayerCommand

var _projectile_scene = preload("res://projectile.tscn")


func execute(player:Player) -> bool:
	var projectile:Projectile = _projectile_scene.instantiate()
	projectile.position = player.position + Vector3(1.25, 0, 0)
	projectile.linear_velocity = Vector3(randf_range(5, 50), randf_range(-10, 10), 0)
	player.add_child(projectile)
	return true

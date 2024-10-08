class_name CollectionNovaCommand
extends PlayerCommand


func execute(player:Player) -> bool:
	for projectile:Projectile in Projectile.projectiles:
		projectile.global_position = player.global_position + Vector3(0, 2.5, 0) + _randVec()
		projectile.linear_velocity = randf() * 50 * _randVec()
	return true

#Returns a normalized instance of Vector3 where x, y, and z are each set to be between -1 and 1.
func _randVec()->Vector3:
	return Vector3(randf_range(-1,1), randf_range(-1,1), randf_range(-1,1)).normalized()

extends Camera2D


func _on_root_new_growth(growth: Node2D) -> void:
	var viewport_size:Vector2 = get_viewport_rect().size
	var center:Vector2 = get_target_position()
	
	# when growth.global_position == center, division by zero results in INF which is safe
	var required_axis_zooms:Vector2 = (viewport_size / 2) / (growth.global_position - center)
	var required_zoom:float = min(abs(required_axis_zooms.x), abs(required_axis_zooms.y))
	
	if required_zoom < zoom.x:
		zoom = Vector2(required_zoom, required_zoom)

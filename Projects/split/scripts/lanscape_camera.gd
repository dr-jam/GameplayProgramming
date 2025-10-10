extends Camera2D


var top_left := Vector2(-1,-1)
var bottom_right := Vector2(1,1)
var padding := Vector2(10,10)
var initialized := false

#look at the incoming growth locations and zoom the camera if they are not visible
func _new_growth(growth:Node2D) -> void:
	var p : Vector2 = growth.global_position
	
	if (not initialized):
		top_left = p
		bottom_right = p
		initialized = true		
	
	
	top_left = Vector2(min(top_left.x,p.x),min(top_left.y,p.y))
	bottom_right = Vector2(max(bottom_right.x,p.x), max(bottom_right.y,p.y))
	
	var center : Vector2 = (top_left + bottom_right) / 2
	global_position = center
	
	var size : Vector2 = (bottom_right - top_left) + padding
	
	var zoom_x : float =  size.x / get_viewport_rect().size.x 
	var zoom_y : float = size.y / get_viewport_rect().size.y 
	
	var zoom_factor = 1 / max(max(zoom_x, 0.2),max(zoom_y,0.2))
	zoom = Vector2(zoom_factor,zoom_factor)

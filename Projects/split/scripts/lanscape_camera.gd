extends Camera2D

var grow: Grow
var cam_zoom: float = 0.49
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grow = %Root
	grow.new_growth.connect(_new_growth)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#look at the incoming growth locations and zoom the camera if they are not visible
func _new_growth(growth:Node2D) -> void:
	# percent_top indicates how much above the top is viewed
	const percent_top : float = 0.1
	const base_zoom_y : float = 324
	var ideal_zoom : float = min(0.49, (base_zoom_y) / (-(1 + percent_top)*(min(-1, growth.global_position.y))))
	if (cam_zoom > ideal_zoom):
		cam_zoom = ideal_zoom
		zoom = Vector2(cam_zoom, cam_zoom)
	return

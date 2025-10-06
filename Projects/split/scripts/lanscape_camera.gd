extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#look at the incoming growth locations and zoom the camera if they are not visible
func _new_growth(growth:Node2D) -> void:
	pass

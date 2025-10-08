extends Button


func _pressed() -> void:
	get_tree().reload_current_scene()

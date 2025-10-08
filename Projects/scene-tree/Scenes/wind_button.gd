extends Button


func _toggled(toggled_on:bool):
	var petals := get_tree().get_nodes_in_group("petals")
	for petal:Petal in petals:
		petal.emit_signal("wind", toggled_on)

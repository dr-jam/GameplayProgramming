extends Button

var _canvas:Node

func _ready() -> void:
	_canvas = get_tree().root.find_child("CherryBlossumTree", true, false) # deep search


func _toggled(toggled_on:bool) -> void:
	if _canvas is CanvasItem:
		if toggled_on:
			(_canvas as CanvasItem).modulate = Color.DIM_GRAY
		else:
			(_canvas as CanvasItem).modulate = Color.WHITE
	get_tree().paused = toggled_on

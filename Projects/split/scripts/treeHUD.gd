extends PanelContainer

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Seed: %s" % %Root.tree_seed
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if 0 == %Root.leaders.size():
		label.text = "the tree is dead"

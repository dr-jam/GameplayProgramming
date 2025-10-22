extends Node3D

enum Spells {
	FIREBALL,
	METEOR,
}

@export var tome: Dictionary[Spells, PackedScene]

@onready var spawn_point = $SpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(tome)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		_create(Spells.FIREBALL)
	elif Input.is_action_just_pressed("ui_down"):
		_create(Spells.METEOR)
		
		
func _create(spell:Spells) -> void:
	var scene:PackedScene = tome[spell]
	var instantiated_scene:Node3D = scene.instantiate() as Node3D
	add_child(instantiated_scene)
	instantiated_scene.global_transform = spawn_point.global_transform

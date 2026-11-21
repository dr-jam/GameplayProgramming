extends RigidBody2D

@export var landings := 0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(_body: Node) -> void:
	landings = landings + 1
	print("landed ", landings)


func _on_body_exited(_body: Node) -> void:
	print("left the ground")

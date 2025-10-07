class_name Grow
extends Node2D

signal new_growth(growth : Node2D)


@export var tree_seed:int
@export_range(0.0, 1.0, 0.01) var grow_chance : float = 0.94
@export_range(0.0, 1.0, 0.01) var split_chance = 0.05
@export_range(0.0, 1.0, 0.01) var death_chance = 0.01
@export_range(0.0, 2.0, 0.1) var timer : float = 0.2

@export var manual:bool = false

var leaders = []
var growth_scene = preload("res://scenes/growth.tscn")
var growths = 0

var cur_time = 0
var roundCount = 0

#for camera info


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seed(tree_seed)
	#randomize()
	var starterGrowth = growth_scene.instantiate()
	leaders.append(starterGrowth)
	add_child(starterGrowth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if manual:
		if !Input.is_action_just_pressed("jump"):
			return
	elif cur_time < timer:
		cur_time += delta
		return
	cur_time = 0
	
	roundCount += 1
	#print("%s" % roundCount)
	var removeList = []
	var addList = []
	
	if leaders.size() == 0:
		print("The tree is dead.")
	
	for leader:Node2D in leaders:
		var randomValue = randf()
		if randomValue < split_chance:
			var leftGrowth:Node2D = growth_scene.instantiate()
			var rightGrowth = growth_scene.instantiate()
			leader.add_child(leftGrowth)
			leftGrowth.transform = leader.transform
			leftGrowth.rotate(-0.01)
			leftGrowth.translate(Vector2(0,-1))
			
			
			leader.add_child(rightGrowth)
			rightGrowth.transform = leader.transform
			rightGrowth.rotate(0.01)
			rightGrowth.translate(Vector2(0,-1))
			
			
			
			var leader_sprite = leader.get_child(0)
			if leader_sprite is Sprite2D:
				(leader_sprite as Sprite2D).modulate = Color.FIREBRICK
			
			removeList.append(leader)
			addList.append(leftGrowth)
			addList.append(rightGrowth)
	
		elif randomValue < split_chance + grow_chance:
			var growth = growth_scene.instantiate()
			leader.add_child(growth)
			growth.transform = leader.transform
			growth.transform.origin = Vector2(0, -5)
			
			var leader_sprite = leader.get_child(0)
			if leader_sprite is Sprite2D:
				(leader_sprite as Sprite2D).modulate = Color.PLUM
			
			removeList.append(leader)
			addList.append(growth)
			
		elif randomValue < split_chance + grow_chance + death_chance:
			print("death")
			var leader_sprite = leader.get_child(0)
			if leader_sprite is Sprite2D:
				(leader_sprite as Sprite2D).modulate = Color.LIGHT_STEEL_BLUE
			removeList.append(leader)
		
	for oldLeader in removeList:
		leaders.erase(oldLeader)
		
	for newLeader:Node2D in addList:
		new_growth.emit(newLeader)
		leaders.append(newLeader)
		

	

extends Action



@export var target_name: String = "target"

@export_group("Wander_Range")
@export var wander_range: int

func tick(actor, delta, blackboard: Dictionary):
	var target: Node3D = Node3D.new()
	self.add_child(target)
	target.global_position.x = randi_range(-wander_range,wander_range)
	target.global_position.y = 0
	target.global_position.z = randi_range(-wander_range,wander_range)
	blackboard.set("target", target)
	#print("NEW TARGET POSITION: ", target.position)
	return STATUS.SUCCESS

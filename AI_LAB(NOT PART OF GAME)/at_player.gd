extends Condition

@export var target_id: String = "target"
@export var stop_dist = 1.5

func tick(actor, delta, blackboard: Dictionary):
	var target = blackboard.get(target_id)
	var dest_dir: Vector3 = target.position - actor.position
	#print(dest_dir.length())
	if target == null:
		#print("AT POSITION")
		return STATUS.FAIL
	elif dest_dir.length() <= stop_dist:
		#print("AT TARGET!")
		return STATUS.SUCCESS
	else:
		return STATUS.RUNNING
	return STATUS.FAIL

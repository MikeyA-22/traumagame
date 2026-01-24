extends Condition

##SIMPLE CONDITION TEMPLATE!!!

## CHECKS IF THE RESPONSE FROM THE BLACK BOARD IS THE SAME AS THE UID.
var in_range: bool
var player

@export_group("Bboard_names")
@export var player_in_range = "player_in_range"
@export var target = "target"

func tick(actor, delta, blackboard: Dictionary):
	if in_range:
		#print("PLAYER IN RANGE!")
		blackboard.set(player_in_range, true)
		blackboard.set(target, player)
		return STATUS.SUCCESS
	else:
		#print("CAN'T FIND PLAYER")
		blackboard.set(player_in_range, false)
		return STATUS.FAIL

func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	#print("body: ", body.name)
	if body.name == "Lab_player":
		in_range = true
		player = body


func _on_area_3d_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
		if body.name == "Lab_player":
			in_range = false
			blackboard.set(target, null)
			

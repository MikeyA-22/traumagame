extends Condition


var player : CharacterBody3D
var spawn_point : Vector3


func tick(actor : Enemy, delta, blackboard: Dictionary):
	player = actor.player
	spawn_point = blackboard.get("spawn_point")
	if Game_Global.hidden == true:
		return STATUS.FAIL
	elif player.global_position.distance_to(actor.global_position) < actor.deaggro_radius and player.global_position.distance_to(actor.global_position) > actor.aggro_radius:
		return STATUS.SUCCESS
	else:
		return STATUS.FAIL

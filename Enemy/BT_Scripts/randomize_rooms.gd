extends Action

var rooms : Array


func tick(actor, delta, blackboard: Dictionary):
	## RECEIVE ROOMS FROM THE BASE ENEMY
	#print("RANDOMIZING ROOMS AT: ", UID)
	rooms = blackboard.get("rooms")
	var next_room = blackboard.get("next_room")
	if rooms == null or Game_Global.current_gState != 1:
		#print("FAILURE, ROOMS ARE: ", rooms, "GAME STATE IS: ", Game_Global.current_gState)
		return STATUS.FAIL
	if next_room == null:
		rooms.shuffle()
		return STATUS.SUCCESS
	return STATUS.SUCCESS
		

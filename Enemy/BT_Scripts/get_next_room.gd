extends Action

var next_room

##ACTION TEMPLATE
##MAYBE MAKE THE ACTOR A CHARACTER3D, or 2D. IDK BRUH...
func tick(actor, delta, blackboard: Dictionary):
	var rooms = blackboard.get("rooms")
	if rooms == null:
		return STATUS.FAIL
	blackboard.set("next_room", rooms[rooms.size() - 1])
	return STATUS.SUCCESS
	

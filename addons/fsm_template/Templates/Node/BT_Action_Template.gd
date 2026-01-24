extends Action

@export var limit: int
var count := 0
##ACTION TEMPLATE
##MAYBE MAKE THE ACTOR A CHARACTER3D, or 2D. IDK BRUH...
func tick(actor, delta, blackboard: Dictionary):
	count += 1
	print(count)

	if count >= limit:
		count = 0
		return STATUS.SUCCESS
	return STATUS.RUNNING

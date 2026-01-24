extends Condition

##SIMPLE CONDITION TEMPLATE!!!

## CHECKS IF THE RESPONSE FROM THE BLACK BOARD IS THE SAME AS THE UID.
@export var response: String

func tick(actor, delta, blackboard: Dictionary):
	var response = blackboard.get(response)
	if UID != response:
		return STATUS.FAIL
	else:
		current_status = STATUS.SUCCESS
		return STATUS.SUCCESS

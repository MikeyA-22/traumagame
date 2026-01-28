extends Condition

##SIMPLE CONDITION TEMPLATE!!!

## CHECKS IF THE RESPONSE FROM THE BLACK BOARD IS THE SAME AS THE UID.
@export var response: String

func tick(actor, delta, blackboard: Dictionary):
	if Input.is_action_just_pressed("onegbosa"):
		return STATUS.SUCCESS
	return STATUS.FAIL

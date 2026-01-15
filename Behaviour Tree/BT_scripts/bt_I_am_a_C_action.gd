extends Condition

@export var response: String
func tick(delta):
	if UID != response:
		return STATUS.FAIL
	else:
		current_status = STATUS.SUCCESS
		return STATUS.SUCCESS

extends Action


@export var message: String

func tick(actor, tick, blackboard):
	if message:
		print(message)
		return STATUS.SUCCESS
	return STATUS.FAIL

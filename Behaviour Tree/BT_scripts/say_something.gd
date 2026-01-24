extends Action


@export var message: String

func tick(actor, tick, blackboard: Dictionary):
		message = blackboard.get("answer")
		print(message)
		return STATUS.SUCCESS

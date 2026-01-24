extends Action


@export var answer: String

var black: Dictionary
func tick(actor, tick, blackboard: Dictionary):
		blackboard.set("answer", answer)
		return STATUS.SUCCESS

extends BehaviourTree
class_name BehaviourNode

enum STATUS {
	FAIL,
	RUNNING,
	SUCCESS
}

var current_status: STATUS
var blackboard: Dictionary

func tick(actor, delta, blackboard):
	pass

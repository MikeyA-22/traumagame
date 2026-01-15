extends BehaviourTree
class_name BehaviourNode

enum STATUS {
	SUCCESS,
	FAIL,
	RUNNING
}

var current_status: STATUS

func tick(delta):
	pass

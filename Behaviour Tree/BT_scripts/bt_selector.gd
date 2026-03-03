@icon("res://Behaviour Tree/icons/selector.svg")
extends Composite
class_name Selector



@export var stop_after_success: bool
@export var stop_after_failure: bool
func tick(actor, delta,blackboard):
	return assess_children(actor, delta, blackboard)
	

func assess_children(actor, delta, blackboard):
	
	stop.emit(false)
	for child in self.get_children():
		if child is BehaviourNode:
			##TASK: REGISTER
			var response = child.tick(actor, delta, blackboard)
			
			if response != STATUS.FAIL:
				if response == STATUS.SUCCESS:
					stop.emit(stop_after_success)
				return response
	print("FAILURE")
	stop.emit(stop_after_failure)
	return STATUS.FAIL

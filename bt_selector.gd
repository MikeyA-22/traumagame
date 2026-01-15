@icon("res://Behaviour Tree/icons/selector.svg")
extends Composite
class_name Selector



@export var stop_after_success: bool
@export var stop_after_failure: bool
func tick(delta):
	return assess_children(delta)
	

func assess_children(delta):
	stop.emit(false)
	for child in self.get_children():
		if child is BehaviourNode:
			var response = child.tick(delta)
			
			if response != STATUS.FAIL:
				if response == STATUS.SUCCESS:
					stop.emit(stop_after_success)
				return response
	print("FAILURE")
	stop.emit(stop_after_failure)
	return STATUS.FAIL

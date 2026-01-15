## ALL CHILDREN MUST RUN SUCCESSFULLY!!!
@icon("res://Behaviour Tree/icons/sequencer.svg")
extends Composite
class_name Sequencer


@export var stop_after_failure: bool

func tick(delta):
	return assess_children(delta)
	
func assess_children(delta):
	##ONE BY ONE ACCESS ALL THE CHILDREN
	for child in self.get_children():
		if child is BehaviourNode:
			## REGISTER CHILD RESPONSE
			var response = child.tick(delta)
			## IF THE RESPONSE IS NOT SUCCESS, WE CAN ASSUME IT IS FAILURE OR RUNNING, EITHER WAY RETURN THE RESPONSEE
			if response != STATUS.SUCCESS:
				print("response is: ", response , " at child ", child.UID)
				return response
		##OUTSIDE OF ALL THIS, RETURN SUCCESS, AS WE CAN ASSUME IT SUCCEEDED IF THE FOR LOOP FINISHED
	stop.emit(stop_after_failure)
	return STATUS.SUCCESS
	

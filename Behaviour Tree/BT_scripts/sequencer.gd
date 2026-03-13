## ALL CHILDREN MUST RUN SUCCESSFULLY!!!
@icon("res://Behaviour Tree/icons/sequencer.svg")
extends Composite
class_name Sequencer


@export var stop_after_failure: bool

func tick(actor, delta, blackboard):
	return assess_children(actor, delta, blackboard)
	
func assess_children(actor, delta, blackboard):
	##ONE BY ONE ACCESS ALL THE CHILDREN
	for child in self.get_children():
		if child is BehaviourNode:
			##TASK: REGISTER BLACKBOARD
			child.blackboard = blackboard
			##TASK: REGISTER CHILD RESPONSE
			var response = child.tick(actor, delta, blackboard)
			
			##TASK: IF THE RESPONSE IS NOT SUCCESS, WE CAN ASSUME IT IS FAILURE OR RUNNING, EITHER WAY RETURN THE RESPONSEE
			if response != STATUS.SUCCESS:
				print("response is: ", response , " at child: ", child.UID)
				return response
		##TASK: OUTSIDE OF ALL THIS, RETURN SUCCESS, AS WE CAN ASSUME IT SUCCEEDED IF THE FOR LOOP FINISHED, SO WE NEEEEED TO MOVE ON TO THE NEXT 
	stop.emit(stop_after_failure)
	return STATUS.SUCCESS
	

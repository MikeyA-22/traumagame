@icon("res://Behaviour Tree/icons/inverter.svg")
extends Decorator

class_name Inverter


func tick(actor, delta, blackboard:Dictionary):
	var child = self.get_child(0)
	var response = child.tick(actor,delta,blackboard)
		
	if response == STATUS.FAIL:
		print("SHOULD RETURN SUCCESS AT: ", UID)
		return STATUS.SUCCESS
	elif response == STATUS.SUCCESS:
		print("SHOULD RETURN FAIL AT: ", UID)
		return STATUS.FAIL
		
		
	return STATUS.RUNNING

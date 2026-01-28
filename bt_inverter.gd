@icon("res://Behaviour Tree/icons/inverter.svg")
extends Decorator

class_name Inverter


func tick(actor, delta, blackboard:Dictionary):
	var child = self.get_child(0)
	var response = child.tick(actor,delta,blackboard)
		
	if response == STATUS.FAIL:
		print("SHOULD RETURN SUCCESS")
		return STATUS.SUCCESS
	if response == STATUS.SUCCESS:
		print("SHOULD RETURN FAIL")
		return STATUS.FAIL
		
		
	return STATUS.RUNNING

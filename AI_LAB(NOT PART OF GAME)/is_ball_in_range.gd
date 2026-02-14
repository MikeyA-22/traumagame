extends Condition

##SIMPLE CONDITION TEMPLATE!!!

## CHECKS IF THE RESPONSE FROM THE BLACK BOARD IS THE SAME AS THE UID.


func tick(actor, delta, blackboard: Dictionary):
	
	var response = blackboard.get("in_range")
	if response == true:
		
		return STATUS.SUCCESS
	else:
		return STATUS.FAIL

extends Condition


func tick(actor, delta, blackboard):
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		print("MOVING")
		return STATUS.SUCCESS
	else:
		return STATUS.SUCCESS

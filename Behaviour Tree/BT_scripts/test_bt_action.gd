extends Action

@export var limit: int
var count := 0


func tick(delta):
	count += 1
	print(count)

	if count >= limit:
		count = 0
		return STATUS.SUCCESS
	return STATUS.RUNNING

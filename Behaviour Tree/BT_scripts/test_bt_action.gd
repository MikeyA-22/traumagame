extends Action

@export var limit: int
var count := 0

##THIS IS A SIMPLE ACTOR TEMPLATE, DOESN'T MAKE USE OF MUCH
## THE ACTOR IS OUR ENEMY OBJECT,
## DELTA IS DELTA
## BLACKBOARD IS DICTIONARY, CONTAINS INFO
func tick(actor,delta,blackboard):
	count += 1
	print(count)

	if count >= limit:
		count = 0
		return STATUS.SUCCESS
	return STATUS.RUNNING

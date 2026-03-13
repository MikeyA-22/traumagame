extends Condition

##SIMPLE CONDITION TEMPLATE!!!

## CHECKS IF THE RESPONSE FROM THE BLACK BOARD IS THE SAME AS THE UID.
var stunned : bool = false

@export var timer: Timer

@export var all_sound_players : Array[AudioStreamPlayer3D]

func _ready() -> void:
	SigBus.connect("STUNNED", Is_Stunned)

func tick(actor, delta, blackboard: Dictionary):
	stunned = blackboard.get("stunned")
	if stunned == true:
		print("STUNNED!!!")
		return STATUS.SUCCESS
	else:
		return STATUS.FAIL
	

func Is_Stunned():
	stunned = true
	blackboard.set("stunned", stunned)
	timer.start()
	for sound in all_sound_players:
		sound.stop()
	

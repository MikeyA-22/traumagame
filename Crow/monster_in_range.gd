extends Condition

##SIMPLE CONDITION TEMPLATE!!!

@export_group("Bboard names")
@export var monster_id: String

@onready var in_range = false
var monster_in_range = false

var monster

func tick(actor, delta, blackboard: Dictionary):
	if in_range:
		#print("PLAYER IN RANGE!")
		blackboard.set(monster_in_range, true)
		blackboard.set(monster_id, monster)
		print("MONSTER IS IN RANGE!")
		return STATUS.SUCCESS
	else:
		#print("CAN'T FIND PLAYER")
		blackboard.set(monster_id, false)
		return STATUS.FAIL
		



func _on_effect_area_body_entered(body: Node3D) -> void:
	if body.name == "Base Enemy":
		in_range = true
		monster = body
		


func _on_effect_area_body_exited(body: Node3D) -> void:
	if body.name == "Base Enemy":
		print("NOT IN RANGE!!")
		in_range = false
		blackboard.set(monster, null)

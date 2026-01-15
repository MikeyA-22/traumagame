@icon("res://Behaviour Tree/icons/action.svg")
extends BehaviourNode
class_name Leaf

func _ready() -> void:
	if self.get_child_count() > 0:
		printerr("WARNING: LEAF %s SHOULD NOT HAVE CHILDREN" % self.UID)
		current_status = STATUS.FAIL

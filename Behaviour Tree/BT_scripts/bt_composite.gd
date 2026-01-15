@icon("res://Behaviour Tree/icons/category_composite.svg")
extends BehaviourNode
class_name Composite


signal stop

func _ready() -> void:
	if self.get_child_count() < 1:
		printerr("WARNING COMPOSITE %s HAS NO CHILDREN!!" % self.UID)
		current_status = STATUS.FAIL

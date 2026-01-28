@icon("res://Behaviour Tree/icons/category_decorator.svg")
extends BehaviourNode

class_name Decorator

func _ready() -> void:
	if self.get_child_count() != 1:
		print("Behaviour Tree error: %s should have only one child!" % self.name)

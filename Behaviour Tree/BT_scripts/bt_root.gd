extends BehaviourTree
class_name root

@onready var child = self.get_child(0)
var stop_tick: bool
func _ready() -> void:
	UID = "ROOT"
	if self.get_child_count() != 1:
		print("Behavior Tree error: Root should have one child")
		return
	child.connect("stop",Callable(self,"is_tick_done"))

func _physics_process(delta: float) -> void:
	if stop_tick == false:
		child.tick(delta)


		
func is_tick_done(done):
	stop_tick = done
	

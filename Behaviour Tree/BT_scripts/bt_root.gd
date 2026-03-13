extends BehaviourTree
class_name root

@onready var child : Composite= self.get_child(0)
var stop_tick: bool

@export var actor: CharacterBody3D
@export var blackboard_resource: Blackboard

var blackboard: Dictionary
func _ready() -> void:
	print("I AM ROOT. I AM WORKING")
	UID = "ROOT"
	if self.get_child_count() != 1:
		print("Behavior Tree error: Root should have one child")
		return
	child.connect("stop",Callable(self,"is_tick_done"))
	blackboard = blackboard_resource.blackboard

func _physics_process(delta: float) -> void:
	print("TICKING")
	if !stop_tick:
		#print("IS TICKING!")
		child.tick(actor, delta, blackboard)
		#print("child is at:", child.tick(actor, delta, blackboard), " ", child.UID)


		
func is_tick_done(done):
	stop_tick = done
	

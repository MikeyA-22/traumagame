extends State
class_name open_door
#Step 1: redefine your class_name

const transition_timing = 0.1
# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "pick"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	if works_longer_than(transition_timing):
		input.actions.sort_custom(priority_sort)
		return input.actions[0]
	else:
		return "okay"

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	pass

func on_enter_state():
	print("entered")
	if Game_Global.current_interactor != null and Game_Global.current_interactor.is_in_group("Doors"):
		print("happens")
		SigBus.DOOR.emit()
	
## Step 5: DELETE THE COMMENTS!! DUMMY...

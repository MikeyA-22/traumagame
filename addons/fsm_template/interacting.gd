extends State
class_name Interacting

const transition_timing = 1.2



@onready var model = $".."
@onready var inventory = $"../Inventory"
@onready var photobook = $"../Photobook"
func _ready() -> void:
	animation = "pick"


func check_request(input: InputPackage):
	if works_longer_than(transition_timing):
		input.actions.sort_custom(priority_sort)
		return input.actions[0]
	else:
		return "okay"


func update(input: InputPackage, delta: float):
		pass
	

func on_enter_state():
	if Game_Global.is_pickable == true:
		if Game_Global.current_pickable is Photo:
			photobook.add(Game_Global.current_pickable)
			#model.set_active_object(Game_Global.current_pickable)
		else:
			inventory.add(Game_Global.current_pickable)
			#debugprintcurrentanimation()
## Step 5: DELETE THE COMMENTS!! DUMMY...

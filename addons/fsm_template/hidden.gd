extends State
class_name Hidden
#Step 1: redefine your class_name

@onready var model = $".."
@onready var hidden = true
# Step 2: redefine your overriden parameters
func _ready() -> void:
	hidden = true
	animation = "idle"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	if !Game_Global.hidden:
		return "idle"
	input.actions.sort_custom(priority_sort)
	return input.actions[0]
	


# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	#print("INSTATEHIDDEN")
	if Input.is_action_just_pressed("interact"):
		print("unhide")

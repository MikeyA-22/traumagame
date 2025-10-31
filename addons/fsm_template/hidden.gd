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
	if !hidden:
		return "idle"
	


# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	pass

## Step 5: DELETE THE COMMENTS!! DUMMY...

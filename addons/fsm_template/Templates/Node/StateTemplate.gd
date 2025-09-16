extends State
class_name NewMove
#Step 1: redefine your class_name

# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "ANIMATION GOES HERE"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	pass

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	pass

## Step 5: DELETE THE COMMENTS!! DUMMY...

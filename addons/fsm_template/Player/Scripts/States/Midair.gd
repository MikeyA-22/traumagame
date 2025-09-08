extends State
class_name Midair
#Step 1: redefine your class_name

@onready var downcast = $"../Downcast"
@onready var root_attachment = $"../Root"

var landing_height : float =  1.63

# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "in_air"
	move_name = "in_air"

# Step 3: implement a check_relevance function
func check_request(input: InputPackage):
	var floor_point = downcast.get_collision_point()
	if root_attachment.global_position.distance_to(floor_point) < landing_height:
		var xz_velocity = player.velocity
		xz_velocity.y = 0
		if xz_velocity.length_squared() >= 10:
			return "landing"
		return "landing"
	else:
		return "okay"

# Step 4: implement an update function
func update(input: InputPackage, delta: float):
	debugprintcurrentanimation()
	player.velocity.y -= gravity * delta * dampener
	player.move_and_slide()

# Step 5: DELETE THE COMMENTS!! DUMMY...

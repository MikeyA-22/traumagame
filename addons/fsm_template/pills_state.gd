extends State
class_name PillsState
#Step 1: redefine your class_name

const transition_timing = 3.333

var pills_amount = 5
@onready var inventory_display = $"../Inventory/InventoryDisplay"
@export var pill_images: Array[Texture2D]
@onready var item_data = load("res://Resource/pills.tres")
# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "Pills"
	move_name = "Pills"

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
	if pills_amount > 0:
		SigBus.PILLS.emit()
		#print(Game_Global.madness_increment)
		
		if Game_Global.madness_increment > 0:
			Game_Global.madness_increment = 0
			RenderingServer.global_shader_parameter_set("heat_strength", Game_Global.madness_increment)
		pills_amount -= 1
		#print(pills_amount)
		Game_Global.pills_amount = pills_amount
		set_info(pills_image(pills_amount))
		display_info(pills_image(pills_amount))
		
func pills_image(pills_amount) -> Texture2D:
	return pill_images[pills_amount]
	
	
func display_info(info):
	inventory_display.display_info(info)
	
func set_info(info):
	item_data.item_info = info

extends MyState
class_name UsePills

const transition_timing = 0.0001

@onready var inventory_display = $"../../Inventory/InventoryDisplay"
@export var pill_images: Array[Texture2D]
@onready var item_data = load("res://Resource/pills.tres")
var pills_amount = 5

func on_enter():
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



func check_transition(input: InputPackage) -> String:
	if works_longer_than(transition_timing):
		return "idle"
	return "okay"

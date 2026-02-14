extends SpotLight3D

class_name FlashlightReceptor

var flash_flag: bool
@export var energy: float = 4
var fs_sfx: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
var on_sfx = preload("res://Music/sfx/flashlight turn on.MP3")
var off_sfx = preload("res://Music/sfx/flashlight turn off.MP3")
@export var flashlight: ItemData


var battery_difference: int = 20
var info_statement: String = "OFF"
@export_group("Battery Variables")
@export var bat_timer: Timer
@export var wait_time: float
@export var bat_min: int = 20
var battery_percent: int = 100
@onready var inventory_display = $"../../../Model/Inventory/InventoryDisplay"


func _ready() -> void:
	light_energy = 0
	SigBus.connect("FLASH", on_flashlight)
	SigBus.connect("OFF_FLASH", off_flashlight)
	SigBus.connect("BATTERIES", recharge_flashlight)
	bat_timer.wait_time = wait_time
	#print("inventory display is: ", inventory_display)
	

func on_flashlight() -> void:
	
	flash_flag = !flash_flag
	if flash_flag == true and battery_percent > bat_min:
		Game_Global.flashlight_value = energy
		light_energy = Game_Global.flashlight_value
		flash_flag = true
		info_statement = "ON"
		assign_sfx(on_sfx)
		play_sfx()
		resource_display("%s: %d" % [info_statement, battery_percent])
		bat_timer.start()
		
		#print(light_energy)
	else:
		off_flashlight()
	

func off_flashlight():
	Game_Global.flashlight_value = 0
	light_energy = Game_Global.flashlight_value
	flash_flag = false
	assign_sfx(off_sfx)
	play_sfx()
	info_statement = "OFF"
	bat_timer.stop()
	resource_display("%s: %d" % [info_statement, battery_percent])
	
	
		#print(light_energy)

func assign_sfx(sfx: AudioStreamMP3):
	if !fs_sfx.get_parent() == self:
		add_child(fs_sfx)
	fs_sfx.stream = sfx
	#pick_sfx.autoplay = true
	fs_sfx.volume_db = 20
	fs_sfx.max_db = 20
	fs_sfx.unit_size = 30
	#
	print("Audio stream loaded:", fs_sfx.stream)

func play_sfx():
	#print("playing pickup?")
	#print("Inside tree:", pick_sfx.is_inside_tree())
	#print("Stream valid:", pick_sfx.stream)
	fs_sfx.play()

func resource_display(info: String):
	set_info(info)
	inventory_display.display_info(info)
	

func set_info(info: String):
	flashlight.item_info = info

func _on_battery_timer_timeout() -> void:
	print("Battery percent: ", battery_percent)
	## EVERYTIME THE TIMER HITS 0, REDUCE PERCENTAGE BY 20
	## DROPS BELOW MINIMUM? KILL IT.
	if battery_percent > bat_min:
		battery_percent -= battery_difference
		bat_timer.wait_time = wait_time
		bat_timer.start()
		if inventory_display.active_item_data.item_name == "Flashlight":
			resource_display("%s: %d" % [info_statement, battery_percent])
		
	else:
		off_flashlight()
		

func recharge_flashlight(bat_charge: int, inventory: Inventory, item_data: ItemData):
	battery_percent += bat_charge
	inventory.switch_item()
	inventory.remove_item_data(item_data)
	set_info("%s: %d" % [info_statement, battery_percent])
	
	if inventory_display.active_item_data.item_name == "Flashlight":
			resource_display("%s: %d" % [info_statement, battery_percent])
	## THE BATTERY SHOULD INCREASE

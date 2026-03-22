extends SpotLight3D

class_name FlashlightReceptor

var flash_flag: bool

var fs_sfx: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
var on_sfx = preload("res://Music/sfx/flashlight turn on.MP3")
var off_sfx = preload("res://Music/sfx/flashlight turn off.MP3")


var battery_percent: int = 100
var battery_difference: int = 20
var info_statement: String = "OFF"
var flashlight_data: ItemData = load("res://Resource/Flashlight.tres")


@export var energy: float = 4

@export_group("Battery Variables")
@export var bat_timer: Timer
@export var wait_time: float = 50
@export var bat_min: int = 20


var inventory_display

@export var bat_image : Array[Texture2D]

func _ready() -> void:
	inventory_display = get_tree().root.find_child("InventoryDisplay", true, false)
	light_energy = 0
	SigBus.connect("FLASH", on_flashlight)
	SigBus.connect("OFF_FLASH", off_flashlight)
	SigBus.connect("BATTERIES", recharge_flashlight)
	bat_timer.wait_time = wait_time
	
	print("FLASHLIGHT NAME IS: ", flashlight_data.item_name)
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
		resource_display(get_bat_image(battery_percent))
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
	resource_display(get_bat_image(battery_percent))
	
	
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

func resource_display(info: Texture2D):
	set_info(info)
	inventory_display.display_info(info)
	

func set_info(info: Texture2D):
	flashlight_data.item_info = info

func _on_battery_timer_timeout() -> void:
	## EVERYTIME THE TIMER HITS 0, REDUCE PERCENTAGE BY 20
	## DROPS BELOW MINIMUM? KILL IT.
	if battery_percent > bat_min:
		battery_percent -= battery_difference
		bat_timer.wait_time = wait_time
		bat_timer.start()
		set_info(get_bat_image(battery_percent))
		if inventory_display.active_item_data.item_name == "Flashlight":
			resource_display(get_bat_image(battery_percent))
		
	else:
		off_flashlight()
	print("Battery percent: ", battery_percent)

func recharge_flashlight(bat_charge: int, inventory: Inventory, item_data: ItemData):
	battery_percent += bat_charge
	inventory.switch_item()
	inventory.remove_item_data(item_data)
	set_info(get_bat_image(battery_percent))
	
	if inventory_display.active_item_data.item_name == "Flashlight":
		resource_display(get_bat_image(battery_percent))
	## THE BATTERY SHOULD INCREASE

func get_bat_image(battery_percent) -> Texture2D:
	if battery_percent > 75:
		return bat_image[0]
	elif battery_percent > 50 and battery_percent < 75:
		return bat_image[1]
	elif battery_percent > 30 and battery_percent < 50:
		return bat_image[2]
	else:
		return bat_image[3]

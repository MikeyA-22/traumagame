extends SpotLight3D

class_name FlashlightReceptor

var flash_flag: bool
@export var energy: float = 4
var fs_sfx: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
var on_sfx = preload("res://Music/sfx/flashlight turn on.MP3")
var off_sfx = preload("res://Music/sfx/flashlight turn off.MP3")


func _ready() -> void:
	light_energy = 0
	SigBus.connect("FLASH", on_flashlight)
	SigBus.connect("OFF_FLASH", off_flashlight)

func on_flashlight() -> void:
	
	flash_flag = !flash_flag
	if flash_flag == true:
		Game_Global.flashlight_value = energy
		light_energy = Game_Global.flashlight_value
		flash_flag = true
		assign_sfx(on_sfx)
		play_sfx()
		#print(light_energy)
	else:
		off_flashlight()
	

func off_flashlight():
	
	Game_Global.flashlight_value = 0
	light_energy = Game_Global.flashlight_value
	flash_flag = false
	assign_sfx(off_sfx)
	play_sfx()
	
		#print(light_energy)

func assign_sfx(sfx: AudioStreamMP3):
	if !fs_sfx.get_parent() == self:
		add_child(fs_sfx)
	fs_sfx.stream = sfx
	#pick_sfx.autoplay = true
	fs_sfx.volume_db = 20
	fs_sfx.max_db = 20
	fs_sfx.unit_size = 30
	print("Audio stream loaded:", fs_sfx.stream)

func play_sfx():
	#print("playing pickup?")
	#print("Inside tree:", pick_sfx.is_inside_tree())
	#print("Stream valid:", pick_sfx.stream)
	fs_sfx.play()

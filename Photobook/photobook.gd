extends Control

class_name Photobook

@export var photoslots:Array[Photoslot]
@onready var anim_player = $AnimationPlayer
var is_open = false
##This is photobook.
##it adds photos to itself, and displays itself at the photoslot. which also
##has its own slot.
func _ready() -> void:
	pass
	


func add(photo: Photo):
	

	
	SigBus.PICKING_UP.emit(photo.messages, photo.time)
	
	var photodata = get_photodata(photo)
	photo.on_picked()
	photo.on_photo_picked()
	
	open_photobook()
	is_open = true
	display(photodata)
	
	
	photo.free()




func display(photodata: PhotoData):
	photoslots[photodata.photo_no].photo.texture = photodata.photo_pic


func get_photodata(photo: Photo)-> PhotoData:
	var photodata = photo.photodata
	return photodata

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("photobook") and is_open:
		close_photobook()
		
	elif event.is_action_pressed("photobook") and not is_open:
		open_photobook()
		
	
func open_photobook():
	anim_player.play("open_photobook")
	is_open = !is_open
	print("opening photobook")
	
func close_photobook():
	anim_player.play("close_photobook")
	print("closing photobook")
	is_open = !is_open
	
	
func set_photo(photodata: PhotoData):
	pass

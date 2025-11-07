extends Control

class_name Photobook

@export var photoslots:Array[Photoslot]

##This is photobook.
##it adds photos to itself, and displays itself at the photoslot. which also
##has its own slot.
func _ready() -> void:
	pass
	


func add(photo: Photo):
	SigBus.PICKING_UP.emit(photo.messages)
	var photodata = get_photodata(photo)
	photo.free()
	display(photodata)


func display(photodata: PhotoData):
	photoslots[photodata.photo_no].photo.texture = photodata.photo_pic

func open():
	pass
	
func close():
	pass

func get_photodata(photo: Photo)-> PhotoData:
	var photodata = photo.photodata
	return photodata

func set_photo(photodata: PhotoData):
	pass

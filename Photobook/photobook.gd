extends Control

class_name Photobook

@export var photoslots:Array[Photoslot]

func _ready() -> void:
	pass
	


func add(photo: Photo):
	SigBus.PICKING_UP.emit(photo.messages)
	var photodata: PhotoData = get_photodata(photo)
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

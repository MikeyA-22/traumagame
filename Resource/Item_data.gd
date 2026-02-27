extends Resource

class_name ItemData


## item name
@export var item_name: String

## item model
@export var item_model: PackedScene

## item photo
@export var item_photo: CompressedTexture2D

var item_info


func _load_item() -> Pickable:
	var item: Pickable = item_model.instantiate()
	return item

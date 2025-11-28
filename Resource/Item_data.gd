extends Resource

class_name ItemData


@export var item_name: String
@export var item_model: PackedScene
@export var item_photo: CompressedTexture2D


func _load_item() -> Pickable:
	var item: Pickable = item_model.instantiate()
	return item

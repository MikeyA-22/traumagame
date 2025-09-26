extends Resource

class_name ItemData


@export var item_name: String
@export var item_model: PackedScene


func _load_item() -> Pickable:
	var item: Pickable = item_model.instantiate(PackedScene.GEN_EDIT_STATE_MAIN_INHERITED)
	return item

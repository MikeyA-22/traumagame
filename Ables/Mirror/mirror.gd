extends Interactable

const SAVE_PATH = "user://save.tres"


func _ready() -> void:
	SigBus.connect("SAVE", save)


func get_interaction_data(player) -> Dictionary:
	return {
		"interactable": true,
		"sig": SigBus.SAVE,
		"sig_value": true,
		"reticle": 1
	}


func save(is_saved: bool) -> void:
	var error_code = ResourceSaver.save(Game_Global.save_game, SAVE_PATH)
	if error_code != OK:
		push_error("Failed to save game: " + error_string(error_code))
		is_saved = false
		
	else:
		is_saved = true
		print("saved! LEVEL IS: ", Game_Global.save_game.level, " INVENTORY IS:", Game_Global.save_game.inventory_items, "ACTIVE ITEM IS:", Game_Global.save_game.active_item, " ACTIVE ITEM DATA IS: ", Game_Global.save_game.active_item.item_info)

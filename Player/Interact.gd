extends Node
class_name Interact


@onready var model  = $".." as PlayerModel


static var interaction : Dictionary = {
	"light_attack_pressed" : 1
}

## INTERACTION TRANSLATOR!! TRANSLATE UNIQUE INTERACTIONS INTO STATE, YOU CLICK AND
## IT TURNS THEM INTO INTERACTIONS!!! IT REROUTES THE INTERACTIONS AND CHECKS IF 
## THEY ARE SPECIAL INTERACTIONS AND IF THEY ARE, IT WORKS !!!
func translate_pickable_actions(new_input: InputPackage):
	if not new_input.interactions.is_empty() and model.active_object != null:
		var translated_into_action_name : String = model.active_object.pickable_action[new_input.interactions[0]]
		print_debug(translated_into_action_name)
		new_input.actions.append(translated_into_action_name)
		#print_debug(translated_into_action_name)
		new_input.actions.append(translated_into_action_name)
	return new_input

extends Node
class_name InteractionManager


@onready var model  = $"../.." as MyModel



static var interaction : Dictionary = {
	"light_attack_pressed" : 1
}

## INTERACTION TRANSLATOR!! TRANSLATE UNIQUE INTERACTIONS INTO STATE, YOU CLICK AND
## IT TURNS THEM INTO INTERACTIONS!!! IT REROUTES THE INTERACTIONS AND CHECKS IF 
## THEY ARE SPECIAL INTERACTIONS AND IF THEY ARE, IT WORKS !!!
func translate_pickable_actions(new_input: InputPackage):
	if not new_input.interactions.is_empty() and model.active_object != null:
		print("MODEL'S ACTIVE OBJECT: ",model.active_object)
		var interaction = new_input.interactions[0]
		if model.active_object.pickable_action.has(interaction):
			var translated_into_interaction : String = model.active_object.pickable_action[interaction]
			print_debug("interaction should be: ", translated_into_interaction)
			new_input.interactions.append(translated_into_interaction)
	return new_input

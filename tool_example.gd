@tool
extends EditorScript
class_name tool_example


var window: Window





var gui = preload("res://sampling_adjuster.tscn")
var gui_scene

# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	window = Window.new()
	EditorInterface.popup_dialog(window,Rect2(Vector2(100,100),Vector2(1280,720)))
	
	gui_scene = gui.instantiate()
	window.add_child(gui_scene)
	
	gui_scene.add_object.connect(_add_object)
	gui_scene.show_objects.connect(_show_objects)
	
	##QUIT BUTTON
	window.close_requested.connect(func():
		window.queue_free()
		)


	
	
func _add_object():
	var selection := EditorInterface.get_selection()
	var nodes := selection.get_selected_nodes()

	if nodes.size() == 0:
		push_warning("No node selected")
		return

	for node in nodes:
		if node is MeshInstance3D:
			#print("MeshInstance",[node],"is: ",node)
			var material: StandardMaterial3D = node.mesh.surface_get_material(0)
			material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		else:
			push_warning("Selected node is not a MeshInstance3D")
	print("did the thing")
			

func _show_objects():
	var selection := EditorInterface.get_selection()
	var nodes := selection.get_selected_nodes()

	if nodes.size() == 0:
		push_warning("No node selected")
		return
	
	for node in nodes:
		gui_scene.object_label.text += str(node, "\n")

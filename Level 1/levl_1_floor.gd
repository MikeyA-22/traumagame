@tool
extends Node

## The group name to assign to StaticBody nodes.
@export var group_name: String = ""

## If true, operates on the currently selected nodes in the editor
## (and their StaticBody descendants) instead of this node's children.
@export var use_selection: bool = false

## Click this to apply the group.
@export var apply_group: bool = false:
	set(value):
		if value and Engine.is_editor_hint():
			_add_static_bodies_to_group()
			apply_group = false

## Click this to remove the group.
@export var remove_group: bool = false:
	set(value):
		if value and Engine.is_editor_hint():
			_remove_static_bodies_from_group()
			remove_group = false


func _add_static_bodies_to_group() -> void:
	if group_name.is_empty():
		push_warning("AddChildrenToGroup: 'group_name' is empty. Please set a group name first.")
		return

	var nodes := _get_static_bodies()
	for node in nodes:
		if not node.is_in_group(group_name):
			node.add_to_group(group_name, true)

	print("AddChildrenToGroup: Added %d StaticBody node(s) to group '%s'." % [nodes.size(), group_name])


func _remove_static_bodies_from_group() -> void:
	if group_name.is_empty():
		push_warning("AddChildrenToGroup: 'group_name' is empty. Please set a group name first.")
		return

	var nodes := _get_static_bodies()
	var count := 0
	for node in nodes:
		if node.is_in_group(group_name):
			node.remove_from_group(group_name)
			count += 1

	print("AddChildrenToGroup: Removed %d StaticBody node(s) from group '%s'." % [count, group_name])


func _get_static_bodies() -> Array[Node]:
	var result: Array[Node] = []
	if use_selection:
		var selected := EditorInterface.get_selection().get_selected_nodes()
		if selected.is_empty():
			push_warning("AddChildrenToGroup: 'use_selection' is on but no nodes are selected.")
			return result
		for node in selected:
			# Include the selected node itself if it's a StaticBody
			if node is StaticBody2D or node is StaticBody3D:
				result.append(node)
			# Also collect any StaticBody descendants beneath it
			result.append_array(_collect_static_bodies(node))
	else:
		result = _collect_static_bodies(self)
	return result


func _collect_static_bodies(node: Node) -> Array[Node]:
	var result: Array[Node] = []
	for child in node.get_children():
		if child is StaticBody2D or child is StaticBody3D:
			result.append(child)
		result.append_array(_collect_static_bodies(child))
	return result

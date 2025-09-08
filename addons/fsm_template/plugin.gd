@tool
extends EditorPlugin

func _enter_tree():
	print("MyAddon enabled")

func _exit_tree():
	print("MyAddon disabled")

extends Node2D

func _ready() -> void:
	if $".".has_node("Control"):
		print_debug()
		$Control/revolver.grab_focus()

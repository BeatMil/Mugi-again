extends Node2D

func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://scene/dew_intro.tscn")

extends Node2D

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://scene/dew_intro.tscn")
	elif Input.is_key_pressed(KEY_C):
		get_tree().change_scene("res://scene/credit.tscn")
		

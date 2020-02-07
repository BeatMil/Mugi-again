extends Node2D

func _input(event):
	if Input.is_key_pressed(KEY_R):
		# var res_path = get_tree().edited_scene_root.get_resource_filesystem() 
		# var res_path = get_tree().get_scene()
		# print(res_path)
		# print(get_tree().change_scene('res://scene/stage01.tscn'))
		# get_tree().change_scene(this_scene)
		get_tree().reload_current_scene()
	elif Input.is_key_pressed(KEY_BACKSPACE):
		get_tree().change_scene("res://scene/Menu.tscn")
	

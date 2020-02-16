extends Sprite


var animu_figs = []


func _ready():
#	print(OS.get_name())
#	print(OS.get_model_name())
#	print(OS.get_real_window_size())
#	var time = OS.get_time()
#	print(time.get("hour"))
#	print(time.get("minute"))
#	print(time.keys())
#	print("-----------------------------")
#	dir_contents("res://media/animu_goods/")
#	print(OS.get_unique_id())
	randomize()
	dir_contents("res://media/animu_goods/")
	animu_figs.shuffle()
	$".".set_texture(animu_figs.front())
	
func beat_set_texture(texture):
	set_texture(texture)
	
func disappear():
	$AnimationPlayer.play("not_feel_good")
	
func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true,true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
#				print("Found directory: " + file_name)
			else:
				if file_name[-1] == "g":
#					print(file_name)
					animu_figs.append(load(dir.get_current_dir() + "/" + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")


func _on_AnimationPlayer_animation_finished(anim_name):
	$".".queue_free()

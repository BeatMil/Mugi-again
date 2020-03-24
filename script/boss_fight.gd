extends Node2D

var animation_list = []
var i = 0 # iterate for animation_list

func _ready() -> void:
	$Timer.start()
	for i in $yggdrasil/AnimationPlayer.get_animation_list():
		animation_list.append(i)



func _on_Timer_timeout() -> void:
	$yggdrasil/AnimationPlayer.play(animation_list[i])
	if i < animation_list.size() - 1:
		i += 1
	else:
		i = 0

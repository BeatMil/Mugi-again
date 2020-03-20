extends Node2D
#const SAYONARA = preload("res://media/Sound/end/Sayo-nara.ogg")
const PLAY_WITH_ME = preload("res://media/Sound/end/Play_With_Me.ogg")

var space : int = 0 # count space then change sprite texture
func _ready() -> void:
	$curtain.set_visible(true)
	$curtain/AnimationPlayer.play("fade_in")
	$AnimationPlayer.play("senko_move_in")
	$"/root/singleton".playsfx($"/root/AudioBlock",PLAY_WITH_ME)
	if $"/root/singleton".gf_clear == false:
		$"/root/singleton".gf_clear = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		space += 1
		if space == 2:
			$AnimationPlayer.play("bear_move_in")
		elif space == 3:
			$AnimationPlayer.play("senko_shake")
		elif space == 5:
			$AnimationPlayer.play("event_move_in")
		

func _on_textPolygon_tree_exited() -> void:
#	$curtain/AnimationPlayer.play("fade_out") # fade out and change scene back to stage02
#	$Timer.start()
	pass

func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://scene/stage02.tscn")

extends Node2D
const SAYONARA = preload("res://media/Sound/end/Sayo-nara.ogg")
func _ready() -> void:
	$"/root/singleton".playsfx($"/root/AudioBlock",SAYONARA)
	if $"/root/singleton".gf_clear == false:
		$"/root/singleton".gf_clear = true
	$curtain/AnimationPlayer.play("fade_in")

func _on_textPolygon_tree_exited() -> void:
	$curtain/AnimationPlayer.play("fade_out")
	$Timer.start()

func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://scene/stage02.tscn")

extends Node2D
const BOOM = preload("res://media/boss_fight/explode3.wav")

func _ready() -> void:
	$AnimationPlayer.play("event_move_in")
	$yggdrasil/AnimationPlayer.play("idle")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "event_move_in":
		$"/root/AudioBlock".stop()
		$AnimationPlayer.play("boom_to_boss_fight")
		$Timer.start()
	elif anim_name == "boom_to_boss_fight":
		get_tree().change_scene("res://scene/boss_fight_transtition.tscn")


func _on_Timer_timeout() -> void:
	$"/root/singleton".playsfx($"/root/SfxBlock",BOOM)

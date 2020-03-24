extends Node2D

var trigger = true # play move_to_boss_position helper

	
func _process(delta: float) -> void:
	if !has_node("textPolygon") and trigger: # check if textPolygon is gone 
		$AnimationPlayer.play("move_to_boss_position")
		trigger = false # line 3


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "move_to_boss_position":
		$AnimationPlayer.play("dew_move_in")
	elif anim_name == "dew_move_in":
		get_tree().change_scene("res://scene/boss_fight.tscn")

extends Node2D
const SAYONARA = preload("res://media/Sound/end/Sayo-nara.ogg")
func _ready() -> void:
	var stream_name = $"/root/AudioBlock".get_stream().get_path().substr(22,9)
	print(stream_name)
	if !stream_name.to_lower().begins_with("sayo"):
		$"/root/singleton".playsfx($"/root/AudioBlock",SAYONARA)

#	print(stream_name.substr(22,-1))			# getting song name
	$"/root/singleton".csgo_clear = true
	$curtain/AnimationPlayer.play("fade_in")


func _on_textPolygon_tree_exited() -> void:
	$curtain/AnimationPlayer.play("fade_out")
	$Timer.start()


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://scene/stage02.tscn")

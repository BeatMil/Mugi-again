extends Node2D
const SAYONARA = preload("res://media/Sound/end/Sayo-nara.ogg")
var space: int = 0 # amount of space press

func _ready() -> void:
	$curtain.set_visible(true)
	var stream_name = $"/root/AudioBlock".get_stream().get_path().substr(22,9)
	print(stream_name)
	if !stream_name.to_lower().begins_with("sayo"):
		$"/root/singleton".playsfx($"/root/AudioBlock",SAYONARA)
	$AnimationPlayer.play("event00")
#	print(stream_name.substr(22,-1))			# getting song name
	$"/root/singleton".csgo_clear = true
	$curtain/AnimationPlayer.play("fade_in")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		space += 1
		if space == 1:
			$AnimationPlayer.play("event01")

func _on_textPolygon_tree_exited() -> void:
	$curtain/AnimationPlayer.play("fade_out")
	$Timer.start()


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://scene/stage02.tscn")

extends Node2D

const FIREFLY = preload("res://media/Sound/credit/firefly.ogg")


func _ready() -> void:
	$stay.set_modulate(Color(1, 1, 1, 0))
	$uppu.set_modulate(Color(1, 1, 1, 0))
	$"/root/singleton".playsfx($"/root/AudioBlock",FIREFLY)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://scene/prestart.tscn")

func _on_Timer_timeout() -> void:
	$uppu.go_up = true
	$dew_sad.go_up = true


func _on_timer_start_timeout() -> void:
	$AnimationPlayer.play("uppu_fade_in")
	$Timer.start()


func _on_timer_end_timeout() -> void:
	print_debug()
	$AnimationPlayer.play("stay_fade_in")

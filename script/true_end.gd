extends Node2D
const MEMORY = preload("res://media/true_end/memory_of_the_lost.ogg")
var space_count = 1
var helper = true # line11 helper
func _ready() -> void:
	$"/root/singleton".playsfx($"/root/AudioBlock",MEMORY)
	$yggdrasil/AnimationPlayer.play("true_end_hurt")
	$yggdrasil/AnimationPlayer2.play("boss_shake")

func _process(delta: float) -> void:
	if !$".".has_node("textPolygon") and helper:
		$yggdrasil/AnimationPlayer2.stop()
		$yggdrasil/AnimationPlayer.play("fade_away")
		helper = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		space_count +=1
	if space_count == 12:
		$yggdrasil/AnimationPlayer.play("true_end_cry")
	elif space_count == 27:
		$yggdrasil/AnimationPlayer.play("true_end_scream")
	elif space_count == 32:
		$yggdrasil/AnimationPlayer.play("true_end_cry")
	elif space_count == 33:
		$yggdrasil/AnimationPlayer.play("true_end_smile")


func _on_yggdrasil_disappear() -> void:
	$curtain.set_visible(true)
	$curtain/AnimationPlayer.play("fade_out")


func _on_curtain_animation_finish(anim_name) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene("res://scene/credit_true_end.tscn")

extends Node2D
const MEMORY = preload("res://media/true_end/memory_of_the_lost.ogg")

func _ready() -> void:
	$"/root/singleton".playsfx($"/root/AudioBlock",MEMORY)
	$yggdrasil/AnimationPlayer.play("true_end_hurt")
	$yggdrasil/AnimationPlayer2.play("boss_shake")

extends Sprite

signal lava_floor

#func _ready() -> void:
#	emit_signal("lava_floor")
#	$AnimationPlayer.play("lava_go")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "lava_go":
		flame_spark(false)

func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	if anim_name == "lava_go":
		emit_signal("lava_floor")
		flame_spark(true)

func flame_spark(switch:bool):
	$Particles2D.set_emitting(switch)
	$Particles2D2.set_emitting(switch)
	

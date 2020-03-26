extends Sprite

func _ready() -> void:
	$AnimationPlayer.play("thin_away")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "thin_away":
		queue_free()

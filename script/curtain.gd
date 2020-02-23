extends ColorRect


signal animation_finish

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("animation_finish",anim_name)

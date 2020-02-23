extends Control


func _ready() -> void:
	$curtain/AnimationPlayer.play("fade_in")
	$AnimationPlayer.play("money_shine")
	$AnimatedSprite.play("idle")
	$Button.grab_focus()

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		$curtain/AnimationPlayer.play("fade_out")




func _on_curtain_animation_finish(anim_name) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene("res://scene/stage02.tscn")

extends Sprite


func _ready() -> void:
	$hitscan/CollisionShape2D.set_disabled(true)
	$AnimationPlayer.play("idle")
	
#func _physics_process(delta: float) -> void:
#	print($Area2D/RayCast2D.get_collider())

func _on_VisibilityNotifier2D_screen_entered() -> void:
	$Timer.start()


func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("shoot")
	$Timer.set_wait_time(1)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Timer.stop()


func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	if anim_name == "shoot":
		$hitscan/CollisionShape2D.set_disabled(false)
	elif anim_name == "die":
		$Timer.stop()
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "shoot":
		$hitscan/CollisionShape2D.set_disabled(true)
	elif anim_name == "die":
		queue_free()
	elif anim_name == "hide":
		$AnimationPlayer.play("shoot")

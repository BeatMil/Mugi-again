extends ColorRect




func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$queue_free_timer.start()


func _on_queue_free_timer_timeout() -> void:
	get_tree().set_pause(false)
	$queue_free_timer.stop()
	$".".queue_free()

extends ColorRect




func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		$queue_free_timer.start()


func _on_queue_free_timer_timeout() -> void:
	get_tree().set_pause(false)
	$queue_free_timer.stop()
	$".".queue_free()

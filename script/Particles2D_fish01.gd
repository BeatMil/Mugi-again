extends Particles2D


func _ready() -> void:
	$".".set_emitting(true)
	$Timer.start()



func _on_Timer_timeout() -> void:
	$".".set_emitting(false)
	$Timer2.start()


func _on_Timer2_timeout() -> void:
	queue_free()

extends Sprite



func _ready() -> void:
	$AnimationPlayer.play("idle")

func _on_VisibilityNotifier2D_screen_entered() -> void:
	$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("shoot")
	pass # Replace with function body.

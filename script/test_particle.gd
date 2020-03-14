extends Node2D

func _ready() -> void:
	$Particles2D.set_emitting(false)
	
func _input(event: InputEvent) -> void:
	if event.is_pressed():
		$Particles2D.set_emitting(true)
		$Timer.start()

func _on_Timer_timeout() -> void:
	$Particles2D.set_emitting(false)

extends Node2D

func _ready() -> void:
	$self_queue_free_timer.start()
	$AudioStreamPlayer.play()

func _physics_process(delta: float) -> void:
	move_local_y(6)


func _on_self_queue_free_timer_timeout() -> void:
	queue_free()

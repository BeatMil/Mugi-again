#boss_healthbar.gd
extends TextureProgress

func _on_boss_healthbar_value_changed(value: float) -> void:
	if value >= 50:
		$".".set_tint_progress(Color(0.003922, 0.752941, 0.67451))
	elif value >= 25:
		$".".set_tint_progress(Color(0.746439, 0.828125, 0.161743)) 
	elif value < 25:
		$".".set_tint_progress(Color(0.839216, 0.031373, 0.031373))

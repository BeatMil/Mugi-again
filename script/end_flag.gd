extends Area2D

signal black_out # transition to another scene


func _on_Area2D_area_entered(area):
	var anim = $"../CanvasLayer/black_out/AnimationPlayer"
	print(area.get_groups())
	if area.is_in_group("player"):
#		emit_signal("black_out")
		$"/root/singleton".current_hp = $"../Player/HealthBar".hp
		anim.play("black_out")
		print(anim.get_animation("black_out").length)
		$Timer.wait_time = anim.get_animation("black_out").length
		$Timer.start()
		


func _on_Timer_timeout():
		get_tree().change_scene("res://scene/stage02.tscn")

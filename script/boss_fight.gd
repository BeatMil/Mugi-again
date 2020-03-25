extends Node2D

var animation_list = []
var i = 0 # iterate for animation_list
var start_health_bar_increase = false #health bar animation at start

func _ready() -> void:
	$boss_healthbar.set_value(0)
	$AnimationPlayer.play("intro_health_increase")
#	$boss_health_timer.start()
	$Timer.start()
	for i in $yggdrasil/AnimationPlayer.get_animation_list():
		animation_list.append(i)

func _physics_process(delta: float) -> void:
	pass
#	if !start_health_bar_increase:
#		$boss_health_timer.start()
#		start_health_bar_increase = true
	



func _on_Timer_timeout() -> void:
	$yggdrasil/AnimationPlayer.play(animation_list[i])
	if i < animation_list.size() - 1:
		i += 1
	else:
		i = 0


func _on_death_border_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		print("RESTART THE GAME!")


func _on_boss_health_timer_timeout() -> void:
	if $boss_healthbar.get_value() < 100:
		$boss_healthbar.value += 1
	else:
		print_debug()
		$boss_health_timer.stop()

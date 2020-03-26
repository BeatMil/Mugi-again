extends Node2D

var animation_list = []
var i = 0 # iterate for animation_list
var start_health_bar_increase = false #health bar animation at start
const SUDDEN_DEATH = preload("res://media/boss_fight/Sudden_Death.ogg")
const UAAUUHHAA01 = preload("res://media/Sound/csgo/friends/dew-auuhhu01.wav")

var meteo_shake_count = 0 # shake camera when meteo goes down

func _ready() -> void:
	$boss_healthbar.set_value(0)
	$AnimationPlayer.play("intro_health_increase")
	if !$"/root/singleton".attended_boss_fight: # keep the song playing even the scene restarts
		$"/root/singleton".playsfx($"/root/AudioBlock",SUDDEN_DEATH)
		$"/root/singleton".attended_boss_fight = true
#	$boss_health_timer.start()  # boss dancing in for loop 5555(2)
#	$Timer.start()		# boss dancing in for loop 5555
	for i in $yggdrasil/AnimationPlayer.get_animation_list(): # loop animation in for loop boss dancing
		animation_list.append(i)

func _physics_process(delta: float) -> void:
	pass

#	if !start_health_bar_increase:
#		$boss_health_timer.start()
#		start_health_bar_increase = true
	


# this function is for boss dancing in for loop
func _on_Timer_timeout() -> void:
	$yggdrasil/AnimationPlayer.play(animation_list[i])
	if i < animation_list.size() - 1:
		i += 1
	else:
		i = 0


func _on_death_border_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		area.get_parent().move_local_x(400)
		$AnimationPlayer.play("intro_health_increase")


# timer for health animation that no need anymore
#func _on_boss_health_timer_timeout() -> void:
#	if $boss_healthbar.get_value() < 100:
#		$boss_healthbar.value += 1
#	else:
#		$boss_health_timer.stop()


func _on_death_border2_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		if $dew_boss/TextureProgress.value > 1:
			$dew_boss/TextureProgress.value -= 4
			$dew_boss.move_local_x(-300)
			$"/root/singleton".playsfx($"/root/SfxBlock",UAAUUHHAA01)
		else:
			area.get_parent().is_dead = true


func _on_dew_die_timer_timeout() -> void:
	get_tree().change_scene("res://scene/boss_fight.tscn")


func _on_find_dew_timer_timeout() -> void:
	if !$".".has_node("dew_boss"):
		get_tree().change_scene("res://scene/boss_fight.tscn")


func _on_yggdrasil_boss_lava_floor() -> void:
	$lava_floor/AnimationPlayer.play("lava_go")
	$Camera2D/AnimationPlayer.play("camera_shake")


func _on_yggdrasil_hadoken() -> void:
	$Camera2D/AnimationPlayer.play("camera_shake")


func _on_yggdrasil_decrease_hp() -> void:	# decrease boss hp 
	$boss_healthbar.value -= 10
	if $boss_healthbar.value <= 30:
		$yggdrasil.phase_two = true


func _on_yggdrasil_meteo() -> void:
	$meteo_shake_timer.start()
	$Camera2D/AnimationPlayer.play("camera_shake")


func _on_meteo_shake_timer_timeout() -> void:
	if meteo_shake_count == 0:
		meteo_shake_count += 1
		$Camera2D/AnimationPlayer.play("camera_shake")
		$meteo_shake_timer.start()
	elif meteo_shake_count == 1:
		$Camera2D/AnimationPlayer.play("camera_shake")
		$meteo_shake_timer.start()
		meteo_shake_count += 1
	elif meteo_shake_count == 2:
		$Camera2D/AnimationPlayer.play("camera_shake")
		$meteo_shake_timer.start()
		meteo_shake_count += 1
	elif meteo_shake_count == 3:
		$Camera2D/AnimationPlayer.play("camera_shake")
		meteo_shake_count = 0
		

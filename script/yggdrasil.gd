#yggdrasil.gd
extends Sprite
const HADOKEN = preload("res://prefab/boss_hadoken.tscn")
const HADOKEN_SFX = preload("res://media/boss_fight/hadoken01.ogg")
const METEO = preload("res://prefab/meteo.tscn")
const METEO2 = preload("res://prefab/meteo2.tscn")
const METEO3 = preload("res://prefab/meteo3.tscn")

var attack_event = 0
var phase_one_switch = false # phase one helper; switch between lava and laser attacks
var phase_two = false
var meteo_count = 1 # help change meteo pattern
var zero_health = false	# dew has beaten the boss

signal hadoken 
signal meteo
signal decrease_hp

signal boss_lava_floor

func _ready() -> void:
	$hurtbox.set_monitoring(false)
	$heart01/AnimationPlayer.play("heart_idle")
	if get_parent().name == "boss_fight":
		$attack_timer_start.start()	#start boss attack after health animation
		$AnimationPlayer.play("idle")



func _on_attack_timer_start_timeout() -> void:
	attack_event += 1
	if !phase_two: # phase 1 here
		if attack_event == 1:
			if phase_one_switch:
				$AnimationPlayer.play("laser")
				phase_one_switch = false
			elif !phase_one_switch:
				$AnimationPlayer.play("floor_lava")
				phase_one_switch = true
		elif attack_event == 2:
			$AnimationPlayer.play("wait")
			attack_event = 0
	else:
		if attack_event == 1:
			$AnimationPlayer.play("meteo")
		elif attack_event == 2:
			$AnimationPlayer.play("floor_lava")
		elif attack_event == 3:
			$AnimationPlayer.play("meteo")
		elif attack_event == 4:
			$AnimationPlayer.play("laser")
		elif attack_event == 5:
			$AnimationPlayer.play("wait")
			attack_event = 0
		
	


func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	if anim_name == "wait":
		$hurtbox.set_deferred("monitoring", true)	# weird error, I have to use set_deferred instead of set_monitoring
#		$hurtbox.set_monitoring(true)
		#E 0:00:19.252   set_monitoring: Function blocked during in/out signal. Use set_deferred("monitoring", true/false).
		$heart01/AnimationPlayer.play("heart_drop")
	elif anim_name == "meteo":
		$lava_down_timer.start()

func _on_AnimationPlayer_animation_changed(old_name: String, new_name: String) -> void:
	# man this doesn't work
	print("oldname: %s"%old_name)
	print("newname: %s"%new_name)
	if old_name == "wait":
		print_debug()
		$AnimationPlayer.play("idle")
		$hurtbox.set_deferred("monitoring", false)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "laser":
		var hadoken = HADOKEN.instance()
		hadoken.set_position($".".position + Vector2(-400,-100))
		hadoken.set_z_index(-6)
		get_parent().add_child(hadoken)
		$"/root/singleton".playsfx($"/root/SfxBlock",HADOKEN_SFX)
		emit_signal("hadoken")
	elif anim_name == "floor_lava":
		emit_signal("boss_lava_floor")
	elif anim_name == "wait":
		$AnimationPlayer.play("idle")
		$hurtbox.set_deferred("monitoring", false)
		$heart01/AnimationPlayer.play_backwards("heart_idle")
	elif anim_name == "hurt" and zero_health:
		get_tree().change_scene("res://scene/true_end.tscn")
	elif anim_name == "hurt":
		$AnimationPlayer.play("idle")
		attack_event = 0


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		emit_signal("decrease_hp")
		area.get_parent().move_local_x(-500)	# push dew away after dew attacked boss
		$AnimationPlayer.play("hurt")
		$heart01/AnimationPlayer.play_backwards("heart_idle")
		$hurtbox.set_deferred("monitoring", false)


func _on_lava_down_timer_timeout() -> void:
	emit_signal("meteo")
	if meteo_count == 1:
		var meteo = METEO.instance()
		meteo.set_position(Vector2(0,0))
		meteo.set_z_index(-5)
		get_parent().add_child(meteo)
		meteo_count += 1
	elif meteo_count == 2:
		var meteo2 = METEO2.instance()
		meteo2.set_position(Vector2(0,0))
		meteo2.set_z_index(-5)
		get_parent().add_child(meteo2)
		meteo_count += 1
	elif meteo_count == 3:
		var meteo3 = METEO3.instance()
		meteo3.set_position(Vector2(0,0))
		meteo3.set_z_index(-5)
		get_parent().add_child(meteo3)
		meteo_count = 1
	
	



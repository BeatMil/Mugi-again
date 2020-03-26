#yggdrasil.gd
extends Sprite
const HADOKEN = preload("res://prefab/boss_hadoken.tscn")
const HADOKEN_SFX = preload("res://media/boss_fight/hadoken01.ogg")

var attack_event = 0
signal hadoken 
signal decrease_hp

signal boss_lava_floor

func _ready() -> void:
	$hurtbox.set_monitoring(false)
	if get_parent().name == "boss_fight":
		$attack_timer_start.start()	#start boss attack after health animation
		$AnimationPlayer.play("idle")



func _on_attack_timer_start_timeout() -> void:
	attack_event += 1
	if attack_event == 1:
		$AnimationPlayer.play("laser")
	elif attack_event == 2:
		$AnimationPlayer.play("floor_lava")
	elif attack_event == 3:
		$AnimationPlayer.play("wait")
		attack_event = 0
	


func _on_AnimationPlayer_animation_started(anim_name: String) -> void:
	if anim_name == "wait":
		$hurtbox.set_deferred("monitoring", true)	# weird error, I have to use set_deferred instead of set_monitoring
#		$hurtbox.set_monitoring(true)
		#E 0:00:19.252   set_monitoring: Function blocked during in/out signal. Use set_deferred("monitoring", true/false).



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
		$hurtbox.set_deferred("monitoring", false)
	elif anim_name == "hurt":
		$AnimationPlayer.play("idle")
		attack_event = 0


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		emit_signal("decrease_hp")
		area.get_parent().move_local_x(-150)
		$AnimationPlayer.play("hurt")
		$hurtbox.set_deferred("monitoring", false)

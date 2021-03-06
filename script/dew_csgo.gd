extends Sprite
enum anum {
	STOP,
	MOVE,
	ATTACK,
	DIE
}
#signal
signal dead

#config
var speed : int = 10
var direction : int = 1# 1 = facing right
var velocity : Vector2

#helper
var on_point : bool = false # shooting
var state
var enemy_ct3 = false
#cache
const SG = preload("res://media/Sound/csgo/csgo/sg556_03.wav")
func raycast_check():
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("enemy"):
			on_point = true
			if $RayCast2D.get_collider().get_parent().name == "enemy_ct3":
				enemy_ct3 = true
	else:
		on_point = false

func move():
#	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
#		$Area2D/CollisionShape2D.set_scale(Vector2(0.5,0.5))
#		$Area2D/CollisionShape2D.set_position(Vector2(0,100))
#		$AnimationPlayer.play("crouch")
#		set_flip_h(false)
#		direction = 1
#		move_local_x((speed - 10) * direction)

# Crouching and walk make it that other animation won't play so I can't make it happen
	if Input.is_action_pressed("ui_down"):
		$Area2D/CollisionShape2D.set_scale(Vector2(0.5,0.5))
		$Area2D/CollisionShape2D.set_position(Vector2(0,100))
		$AnimationPlayer.play("crouch")
	elif Input.is_action_just_released("ui_down"):
		$Area2D/CollisionShape2D.set_scale(Vector2(1,1))
		$Area2D/CollisionShape2D.set_position(Vector2(0,0))
		$AnimationPlayer.play("idle")
	elif Input.is_action_pressed("ui_right"):
		set_flip_h(false)
		direction = 1
		move_local_x(speed * direction)
	elif Input.is_action_pressed("ui_left"):
		set_flip_h(true)
		direction = -1
		move_local_x(speed * direction)

func attack():
	if Input.is_action_just_pressed("ui_accept") and !on_point:
		$AnimationPlayer.play("gun_jamed")
	elif Input.is_action_just_pressed("ui_accept") and on_point and !Input.is_action_pressed("ui_down"):
		if $RayCast2D.get_collider().is_in_group("enemy") and enemy_ct3:
			$"../AnimationPlayer".play("event07")
			$"/root/singleton".playsfx($AudioStreamPlayer,SG)
			$RayCast2D.get_collider().get_parent().get_node("Timer").stop()
			$RayCast2D.get_collider().get_parent().get_node("AnimationPlayer").play("die")
		elif $RayCast2D.get_collider().is_in_group("enemy"):
			$"/root/singleton".playsfx($AudioStreamPlayer,SG)
			$timer_after_kill_speech.start()
			$RayCast2D.get_collider().get_parent().get_node("Timer").stop()
			$RayCast2D.get_collider().get_parent().get_node("AnimationPlayer").play("die")
		
		
	# up, down movement. I don't want those.
#	if Input.is_action_pressed("ui_up"):
#		move_local_y(-speed)
#	elif Input.is_action_pressed("ui_down"):
#		move_local_y(speed)

func _ready() -> void:
	state = anum.STOP
	$RayCast2D.set_collide_with_areas(true)
	$RayCast2D.set_collide_with_bodies(false)
	$AnimationPlayer.play("idle")

func _physics_process(delta: float) -> void:
	$AudioStreamPlayer.set_volume_db($"/root/singleton".volume)
	$label_state.text = str(anum.keys()[state])
#	if state != anum.STOP and state != anum.DIE:
	if state == anum.MOVE:
		raycast_check() # if enemy is infront, 
		move()
		attack()


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.name == "hitscan":
#		$Area2D.set_monitoring(false)
#		$Area2D.set_deferred("monitoring",false)
		$Area2D.disconnect("area_entered",self,"_on_Area2D_area_entered")
		$AnimationPlayer.play("die")
		state = anum.DIE
		get_node("timer_dead").start()
#		$Area2D/CollisionShape2D.set_disabled(true)
		$Area2D/CollisionShape2D.set_deferred("disabled",true)
		$timer_after_kill_speech.stop()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "die":
		emit_signal("dead")


func _on_timer_after_kill_speech_timeout() -> void:
	$AnimationPlayer.play("kill01")

extends Sprite
var speed = 16
var is_jumping = false # use to prevent keep jumping
var is_dead = false
var is_dead_helper = false # helper is_dead
const DEW_HURT = preload("res://media/boss_fight/dew-hurt02.wav")
const ERROR = preload("res://media/boss_fight/sfx_sounds_error3.wav")
func _ready() -> void:
	$TextureProgress.value = 5
	pass
	
func _physics_process(delta: float) -> void:
	if !is_dead:
		if Input.is_action_pressed("ui_down"):
			$AnimationPlayer.play("crouch")
			set_to_crouch_hurtbox()
			prevent_one_frame_bug()
		elif Input.is_action_just_released("ui_down"):
			$AnimationPlayer.play("idle")
			set_to_stand_hurtbox()
		elif Input.is_action_just_pressed("ui_up") and !is_jumping:
			$AnimationPlayer.play("jump")
			set_to_jump_hurtbox()
			is_jumping = true
			$jump_timer.start()
	#	elif Input.is_action_just_released("ui_up"):
		elif Input.is_action_just_released("ui_right") and is_jumping: # don't change animation while jumping
			pass
		elif Input.is_action_just_released("ui_left") and is_jumping: # don't change animation while jumping
			pass
		elif Input.is_action_just_released("ui_right"):
			$AnimationPlayer.play("idle")
		elif Input.is_action_just_released("ui_left"):
			$AnimationPlayer.play("idle")
		elif Input.is_action_pressed("ui_right") and is_jumping:
			$".".set_flip_h(false)
			move_local_x(speed)
		elif Input.is_action_pressed("ui_left") and is_jumping:
			$".".set_flip_h(true)
			move_local_x(-speed)
		elif Input.is_action_pressed("ui_right"):
			$AnimationPlayer.play("walk")
			set_to_stand_hurtbox()
			$".".set_flip_h(false)
			move_local_x(speed)
			prevent_one_frame_bug()
		elif Input.is_action_pressed("ui_left"):
			$AnimationPlayer.play("walk")
			set_to_stand_hurtbox()
			$".".set_flip_h(true)
			move_local_x(-speed)
			prevent_one_frame_bug()
		elif Input.is_action_just_pressed("ui_accept"):
			$"/root/singleton".playsfx($AudioStreamPlayer,ERROR)
	elif is_dead and !is_dead_helper:
		$AnimationPlayer.play("death")
		is_dead_helper = true # make it stop playing the death animation



func prevent_one_frame_bug(): #set to prevent 1 frame stand while crouching after jumping
	is_jumping = false 
	$jump_timer.stop()

func set_to_crouch_hurtbox():
	$Area2D/CollisionShape2D.set_scale(Vector2(0.4,0.4))
	$Area2D/CollisionShape2D.set_position(Vector2(0,100))

func set_to_stand_hurtbox():
	$Area2D/CollisionShape2D.set_scale(Vector2(1,1))
	$Area2D/CollisionShape2D.set_position(Vector2(0,0))

func set_to_jump_hurtbox():
	$Area2D/CollisionShape2D.set_scale(Vector2(0.2,0.2))
	$Area2D/CollisionShape2D.set_position(Vector2(0,-100))



func _on_jump_timer_timeout() -> void:
	$AnimationPlayer.play("idle")
	set_to_stand_hurtbox()
	is_jumping = false


func _on_TextureProgress_value_changed(value: float) -> void:
	if value > 3:
		$TextureProgress.set_tint_progress(Color(0.007843, 0.792157, 0))
	else:
		$TextureProgress.set_tint_progress(Color(0.890196, 0.07451, 0.07451))
	
	if value <= 0:
		is_dead = true


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		$TextureProgress.value -= 3
		$"/root/singleton".playsfx($AudioStreamPlayer,DEW_HURT)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "death":
		queue_free()

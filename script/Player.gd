#Player.gd
extends KinematicBody2D

#enum {
#	IDLE,
#	AIR,
#	RECOVERY,
#	BLOCK
#}
enum anum {
	IDLE,
	MOVE,
	AIR,
	RECOVERY,
	BLOCK,
	ATTACK,
	AIR_ATTACK,
	DEAD
}

# const anum = {
# 	IDLE = 0,
# 	MOVE = 1,
#  	AIR = 2,
#  	RECOVERY = 3,
# 	BLOCK = 4,
# 	ATTACK = 5,
# 	DEAD = 6
#  }
var state2 = 0 # a bug that I can't fix. Just leave it there
var state = 0

# Configuration
var gravity = 90
var ground = Vector2(0,-1)
var jumpPower = 2000
var walkPower = 500
var hp_max = 5.00  # float for calculation. 
					#being used in HealthBar.gd

# var is_dead = false
# var is_attacking = false # changing to state ATTACK
var velocity = Vector2()
var direction = 1 	# 1 = facing right

signal dead
signal damaged

#Cache
const FIREBALL = preload("res://prefab/Hadoken.tscn")
const ATTACK02 = preload("res://prefab/attack02.tscn")
const DIALOG01 = preload("res://prefab/dialog.tscn")
onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var collision = get_node('CollisionShape2D')
onready var area = get_node('Stand')
onready var health_bar = $"."/HealthBar
onready var timer_attack = $"Timer_attack"
onready var attack02_timer = $"attack02-timer"
onready var recover_timer = $"Recovery-timer"

# area2D collision changer
var stand_collision_position = Vector2()
var crouch_collision_position = Vector2() 
var stand_collision_scale = Vector2()
var crouch_collision_scale = Vector2()

# kinematic2D collision changer
# var stand_kinematic_position = Vector2()
# var crouch_kinematic_position = Vector2()
# var stand_kinematic_scale = Vector2()
# var crouch_kinematic_scale = Vector2()

# helper
var count = false # dead() helper
var air_attack = false # air state helper
var input = "" # display input in state_label

func _ready():
	add_to_group("player")
	stand_collision_position = Vector2(area.get_position().x, 34)
	crouch_collision_position = Vector2(area.get_position().x, 80)
	stand_collision_scale = Vector2(1,1)
	crouch_collision_scale = Vector2(1,0.5)
	state2 = 0
	
	
func _physics_process(delta):
	if state != anum.DEAD:
		if state != anum.ATTACK:
			if state != anum.RECOVERY:
					Gravity()
					if state != anum.BLOCK: # if not blocking can do below 
						if state == anum.AIR_ATTACK:
							Move()
							_jump()
						else:
							Move()
							Crouch()
							_jump()
							lerpFish()
					attack()
					velocity = move_and_slide(velocity,ground)
					dead_check()
			elif state == anum.RECOVERY:
				recovery_from_enemy()
		else:
			Gravity()
			velocity = move_and_slide(velocity,ground) # this two line (106,107) keep the player on moving platform
														# while attacking
	else:
		dead()
		
func _input(event):
	if event.is_pressed():
		input = event.as_text()
#		print(event.as_text())
		
#		if event.as_text() == "8":
#			lerpFish()
func lerpFish():
#	if Input.is_key_pressed(KEY_8):
	if Input.is_action_just_pressed("cheat_08"): #KEY_8
		velocity.x = 800
		while velocity.x > 0:
			velocity.x -= 10
			velocity = move_and_slide(velocity,ground)
			print(get_floor_velocity())
func Move():
	if Input.is_action_pressed("ui_right"):
		direction = 1
		velocity.x = walkPower * direction
		sprite.set_flip_h(false)
		if !air_attack:
			anim.play("run")
			state = anum.MOVE
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		velocity.x = walkPower * direction
		sprite.set_flip_h(true)
		if !air_attack:
			anim.play("run")
			state = anum.MOVE
	else:
		velocity.x = 0
		if !air_attack:
			anim.play("idle")
			state = anum.IDLE
		
func Crouch():
	if Input.is_action_pressed("ui_down") and is_on_floor():
		velocity.x = 0
		anim.play("crouch")
		area.set_position(crouch_collision_position)
		area.set_scale(crouch_collision_scale)
		collision.set_position(crouch_collision_position)
		collision.set_scale(crouch_collision_scale)
	else:
		area.set_position(stand_collision_position)
		area.set_scale(stand_collision_scale)
		collision.set_position(stand_collision_position)
		collision.set_scale(stand_collision_scale)

func _jump():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		state = anum.AIR
		velocity.y = -jumpPower
		
	if Input.is_action_just_released("ui_up") and !is_falling():
		velocity.y = gravity
		
	if !is_on_floor():
		if air_attack:
			state = anum.AIR_ATTACK
			if get_parent().has_node("attack02"):
				get_node("../attack02").set_position($".".get_position() + Vector2(150 * direction,0))
#			attack02.set_position($".".get_position() + Vector2(150 * direction,0))
		else:
			state = anum.AIR

		if state == anum.AIR:
			anim.play("jump")
			if is_falling():
				anim.play('falling')
		elif state == anum.AIR_ATTACK:
			anim.play("attack03")

	else:
		air_attack = false
		if get_parent().has_node("attack02"):
			get_parent().get_node("attack02").queue_free()




		

func attack():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		# is_attacking = true
		state = anum.ATTACK
		timer_attack.start()
		$"hadoken-timer".start()
		anim.play("attack01")
		velocity = Vector2.ZERO
		# var fireball = FIREBALL.instance()
		# fireball.set_position($".".get_position() + Vector2(100 * direction,0))
		# $"..".add_child(fireball)
	elif Input.is_action_just_pressed("attack02") and is_on_floor(): #control
		# is_attacking = true
		state = anum.ATTACK
		attack02_timer.start()
		velocity = Vector2.ZERO
		# if sprite.is_flipped_h():
		# 	sprite.set_position(Vector2(1000,1000))
		# 	anim.play("attack02")
		# 	print(sprite.position)
		# else:
		# 	sprite.set_position(Vector2(0,0))
		# 	anim.play("attack02")
		# 	print("not flip h")
# it doesn't work I can't make it work			
		anim.play("attack02")
		var attack02 = ATTACK02.instance()
		attack02.set_position($".".get_position() + Vector2(150 * direction,0))
		$"..".add_child(attack02)
	elif Input.is_action_just_pressed("attack02") and !is_on_floor():
		air_attack = true	
		var attack02 = ATTACK02.instance()
		attack02.set_position($".".get_position() + Vector2(150 * direction,0))
		$"..".add_child(attack02)
	elif Input.is_action_pressed("block"):
		state = anum.BLOCK
		anim.play("block01")
	elif Input.is_action_just_released("block"):
		state = anum.IDLE

func recovery_from_enemy():
	velocity = Vector2(1500 * -direction,-400)
	velocity = move_and_slide(velocity, ground)
	anim.play("damaged01")
	
func Gravity():
	velocity.y += gravity

func DirectionSwitch(): # unused
	direction *= -1
	
func dead():
	if !count:
		emit_signal("dead")
		count = true
	velocity = Vector2.ZERO
	collision.set_disabled(true)
	
	move_and_slide(velocity,ground)	
	anim.play("dead")
	
func is_falling():
	if velocity.y > 0:
		return true
	else:
		return false

func dead_check():
	if health_bar.hp <= 0:
		state = anum.DEAD

func _on_Timer_timeout():
	# is_attacking = false
	state = anum.IDLE

func _on_Recovery_timeout():
	state = anum.IDLE
	recover_timer.stop()

func _on_attack02timer_timeout():
	if get_parent().has_node("attack02"):
		get_parent().get_node("attack02").queue_free()
	# is_attacking = false
	state = anum.IDLE
	attack02_timer.stop()


func _on_Stand_area_entered(area):
#	print(area.get_groups())
	if area.is_in_group("enemy") and state != anum.BLOCK:
		health_bar.health_decrease(1)
		# velocity = move_and_slide(Vector2(12000 * -direction,-1000), ground)
		state = anum.RECOVERY
		emit_signal("damaged") # for SFX
		recover_timer.start()
	elif area.is_in_group("enemy") and state == anum.BLOCK:
		# velocity = move_and_slide(Vector2(9000 * -direction,-1000), ground)
		state = anum.RECOVERY
		recover_timer.start()
	elif area.is_in_group("hp_up"):
		health_bar.health_increase(1)
		$"../CanvasLayer/dialog/WindowDialog".popup(Rect2(500,100,700,100))
#		var dlog = DIALOG01.instance()
#		$"..".add_child(dlog)
#		dlog.WindowDialog.popup(Rect2(500,100,700,100))
#		print(dlog.name)
#		dlog.get_children()[0].popup(Rect2(500,100,700,100))
	elif area.is_in_group("death_border"):
		get_tree().reload_current_scene()
#	elif area.is_in_group("spikes"):
#		health_bar.health_decrease(1)
#		state = anum.RECOVERY
#		emit_signal("damaged") # for SFX
#		recover_timer.start()


func _on_hadokentimer_timeout():
	var fireball = FIREBALL.instance()
	fireball.set_position($".".get_position() + Vector2(100 * direction,0))
	$"..".add_child(fireball)
	$"hadoken-timer".stop()

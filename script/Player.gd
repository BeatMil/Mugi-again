#Player.gd
extends KinematicBody2D

var state = IDLE
enum {
	IDLE,
	AIR,
	RECOVERY,
	BLOCK
}
# Configuration
var gravity = 90
var ground = Vector2(0,-1)
var jumpPower = 2000
var walkPower = 500
var hp_max = 5.00  # float for calculation. 
#being used in HealthBar.gd

var is_dead = false
var is_attacking = false
var velocity = Vector2()
var direction = 1 	# 1 = facing right

signal dead
signal damaged
signal state_change

#Cache
const FIREBALL = preload("res://prefab/Hadoken.tscn")
const ATTACK02 = preload("res://prefab/attack02.tscn")
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

var count = false # dead() helper

func _ready():
	stand_collision_position = Vector2(area.get_position().x, 34)
	crouch_collision_position = Vector2(area.get_position().x, 80)
	stand_collision_scale = Vector2(1,1)
	crouch_collision_scale = Vector2(1,0.5)
	print("state: %s" % state)
	pass
func _physics_process(delta):
	# print("state: %s" % state)
	if !is_dead:
		if !is_attacking and state != RECOVERY:
			Gravity()
			if state != BLOCK:
				Move()
				Crouch()
				Jump()
			velocity = move_and_slide(velocity,ground)
			attack()
			dead_check()
		elif state == RECOVERY:
			recovery_from_enemy()
	else:
		dead()
		
	


func Move():
	if Input.is_action_pressed("ui_right"):
		direction = 1
		velocity.x = walkPower * direction
		
		sprite.set_flip_h(false)
		anim.play("run")
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		velocity.x = walkPower * direction
		sprite.set_flip_h(true)
		anim.play("run")
	else:
		velocity.x = 0
		anim.play("idle")
		state = IDLE
		
func Jump():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jumpPower
		
	if Input.is_action_just_released("ui_up") and !is_falling():
		velocity.y = gravity
		
	if !is_on_floor():
		anim.play("jump")
		if is_falling():
			anim.play('falling')
		state = AIR
	
		
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

func attack():
	if Input.is_action_just_pressed("ui_accept"):
		is_attacking = true
		timer_attack.start()
		anim.play("attack01")
		var fireball = FIREBALL.instance()
		fireball.set_position($".".get_position() + Vector2(100 * direction,0))
		$"..".add_child(fireball)
	elif Input.is_action_just_pressed("attack02") and is_on_floor(): #control
		is_attacking = true
		attack02_timer.start()
		anim.play("attack02")
		var attack02 = ATTACK02.instance()
		attack02.set_position($".".get_position() + Vector2(150 * direction,0))
		$"..".add_child(attack02)
	elif Input.is_action_pressed("block"):
		state = BLOCK
		anim.play("block01")
	elif Input.is_action_just_released("block"):
		state = IDLE

func recovery_from_enemy():
	velocity = Vector2(300 * -direction,-800)
	velocity = move_and_slide(velocity, ground)
	anim.play("damaged01")
	
func Gravity():
	velocity.y += gravity

func DirectionSwitch(): # unused
	direction *= -1
	
func dead():
	if !count:
		emit_signal("dead")
		print("sound")
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

func _on_Area2D_body_entered(body):
	# var tag : String = body.get_meta('type')
	if body.is_in_group("enemy") and state != BLOCK:
		health_bar.health_decrease(1)
		velocity = move_and_slide(Vector2(9000 * -direction,-1000), ground)
		state = RECOVERY
		emit_signal("damaged") # for SFX
		recover_timer.start()
	elif body.is_in_group("enemy") and state == BLOCK:
		velocity = move_and_slide(Vector2(9000 * -direction,-1000), ground)
		state = RECOVERY
		recover_timer.start()


	# print(body.get_node(".").name)

	
func dead_check():
	if health_bar.hp <= 0:
		is_dead = true

func _on_Timer_timeout():
	is_attacking = false

func change_state(state):
	state = state
	emit_signal("state_change")

func _on_Player_state_change():
	print("state: %s" % state)


func _on_Recovery_timeout():
	state = IDLE
	recover_timer.stop()


func _on_attack02timer_timeout():
	if get_parent().has_node("attack02"):
		get_parent().get_node("attack02").queue_free()
	is_attacking = false
	attack02_timer.stop()

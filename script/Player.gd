#Player.gd
extends KinematicBody2D

# Configuration
var gravity = 90
var ground = Vector2(0,-1)
var jumpPower = 2000
var walkPower = 500
var hp = 3

var is_dead = false

var velocity = Vector2()
var direction = 1 	# 1 = facing right

signal dead


#Cache
onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var collision = get_node('CollisionShape2D')
onready var area = get_node('Stand')

# area2D collision changer
var stand_collision_position = Vector2()
var crouch_collision_position = Vector2() 
var stand_collision_scale = Vector2()
var crouch_collision_scale = Vector2()

# kinematic2D collision changer
"""
var stand_kinematic_position = Vector2()
var crouch_kinematic_position = Vector2()
var stand_kinematic_scale = Vector2()
var crouch_kinematic_scale = Vector2()
"""
var count = false # dead() helper

func _ready():
	stand_collision_position = Vector2(area.get_position().x, 34)
	crouch_collision_position = Vector2(area.get_position().x, 80)
	stand_collision_scale = Vector2(1,1)
	crouch_collision_scale = Vector2(1,0.5)
	
	pass
func _physics_process(delta):
	if !is_dead:
		Gravity()
		Move()
		Jump()
		Crouch()
		velocity = move_and_slide(velocity,ground)
		dead_check()
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
		
func Jump():
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jumpPower
		
	if Input.is_action_just_released("ui_up") and !is_falling():
		velocity.y = gravity
		
	if !is_on_floor():
		anim.play("jump")
		if is_falling():
			anim.play('falling')
	
		
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
	var tag : String = body.get_meta('type')
	if 'enemy' == tag:
		hp -= 1
		print("hp: %s" % hp)

func dead_check():
	if hp <= 0:
		is_dead = true
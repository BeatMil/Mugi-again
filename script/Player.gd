#Player.gd
extends KinematicBody2D

# Configuration
var gravity = 90
var ground = Vector2(0,-1)
var jumpPower = 2000
var walkPower = 500

var is_dead = false

var velocity = Vector2()
var direction = 1 	# 1 = facing right

signal dead


#Cache
onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var collision = get_node('CollisionShape2D')

var count = false


func _ready():
	pass
	
func _physics_process(delta):
	if !is_dead:
		Gravity()
		Move()
		Jump()
		Crouch()
		velocity = move_and_slide(velocity,ground)
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
	if Input.is_action_pressed("ui_down"):
		velocity.x = 0
		anim.play("crouch")
	
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
		is_dead = true
	

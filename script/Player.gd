extends KinematicBody2D
#Player.gd

# Configuration
var gravity = 90
var ground = Vector2(0,-1)
var jumpPower = 1500
var walkPower = 240

var is_death = false


#Cache
onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
var velocity = Vector2()
var direction = 1 	# 1 = facing right
var falling = false

func _ready():
	pass
	
func _physics_process(delta):
	print('on floor %s' %is_on_floor())
	if !is_death:
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
		
func Crouch():
	if Input.is_action_pressed("ui_down"):
		velocity.x = 0
		anim.play("crouch")
	
func Gravity():
	velocity.y += gravity

func CollisionCheck():
	if get_slide_count() > 1:
		for i in range(get_slide_count()):
			var getType : String = get_slide_collision(i).collider.get_meta("type")
			if getType == "enemy":
				is_death = true

func DirectionSwitch(): # unused
	direction *= -1
	
func dead():
	if !is_on_floor():
		velocity = Vector2(100,100)
		move_and_slide(velocity,ground)
	else:
		velocity = Vector2(0,100)
		move_and_slide(velocity,ground)
		
	
	
func is_falling():
	if velocity.y > 0:
		return true
	else:
		return false

func _on_Area2D_body_entered(body):
#	print('%s %s'%[body.name, body.get_meta('type')])
	var tag : String = body.get_meta('type')
	if 'enemy' == tag:
		is_death = true
	pass
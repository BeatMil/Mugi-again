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
	if !is_death:
		Gravity()
		Move()
		Jump()
		Crouch()
		velocity = move_and_slide(velocity,ground);
		CollisionCheck()
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
			print("getType: %s"%getType)
			if getType == "enemy":
				dead()

func DirectionSwitch(): # unused
	direction *= -1

func sayWord(word):
	print("Mugi: %s" %(word))
	anim.play("jump")
	
func dead():
	is_death = true
	velocity.normalized()
	print("dead")
	
	
func is_falling():
	if velocity.y > 0:
		return true
	else:
		return false
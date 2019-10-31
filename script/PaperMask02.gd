extends KinematicBody2D

enum {
	IDLE,
	JUMP,
	MOVE
	MOVE_LEFT
}
var enum_array = [IDLE,JUMP,MOVE,MOVE_LEFT]
onready var sprite = $"Sprite"

const SPEED = 100
const JUMP_POWER = 500
var state = JUMP
var motion2 = Vector2()
var direction = 1 # 1 = facing rightc
var gravity = 10
var ground = Vector2(0,-1)
func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	gravity()
	# print("%s motion2: %s" %[$".".name,motion2])
	match state:
		IDLE:
			motion2 = Vector2(0,0)

		JUMP:
			jump()

		MOVE:
			move(delta)
		MOVE_LEFT:
			move_left(delta)
	motion2 = move_and_slide(motion2,ground)
	# change_state_ramdomly([IDLE,JUMP,MOVE])
	

func gravity():
	motion2.y += gravity

func move(delta):
	sprite.set_flip_h(false)
	motion2.x = direction * SPEED 
	# position += direction * SPEED * delta
func move_left(delta):
	sprite.set_flip_h(true)
	motion2.x = direction * -1 * SPEED 
	
func jump():
	if is_on_floor():
		motion2.y -= JUMP_POWER

func change_state_ramdomly(array):
	array.shuffle()
	state = array.front()
	# return array[0] # or array.front()


func _on_Timer_timeout():
	change_state_ramdomly(enum_array)

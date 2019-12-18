extends KinematicBody2D

enum {
	IDLE,
	AIR,
	JUMP,
	MOVE,
	MOVE_LEFT,
	RECOVERY_HIT
}
var enum_array = [IDLE,JUMP,MOVE_LEFT,MOVE_LEFT,MOVE_LEFT,MOVE]
var pre_state = IDLE # just a default value

onready var sprite = $"Sprite"
onready var player = get_node("../Player")


# configuration
const SPEED = 100
const JUMP_POWER = 500
var gravity = 10
var hp = 6





var state = MOVE
var motion2 = Vector2()
var direction = 1 # 1 = facing rightc
var ground = Vector2(0,-1)
func _ready():
	add_to_group("enemy")

func _physics_process(delta):
#	print("%s state: %s"%[$".".name,state])
	# print("%s motion2: %s" %[$".".name,motion2])
#	if !is_on_floor():
#		state = AIR
#	else:
#		state = IDLE
	gravity()
	if state != RECOVERY_HIT and is_on_floor():
		if state != AIR:
			match state:
				IDLE:
					motion2 = Vector2(0,0)
				JUMP:
					jump()
				MOVE:
					move(delta)
				MOVE_LEFT:
					move_left(delta)
		else: # state == AIR
			$"Timer".stop()
	motion2 = move_and_slide(motion2,ground)
	

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
	if pre_state == MOVE_LEFT:
		motion2.x = -SPEED
	elif pre_state == MOVE:
		motion2.x = SPEED
	motion2.y -= JUMP_POWER

func change_state_ramdomly(array):
	array.shuffle()
	state = array.front()
	# return array[0] or array.front()
func _on_Timer_timeout():
	pre_state = state
	change_state_ramdomly(enum_array)

func being_damaged(amount):
	hp -= amount

func recovery_hit():
	state = RECOVERY_HIT
	$"./Timer".stop()
	$"./Recover01".start()
	motion2 = Vector2(400 * player.direction,-100)
	motion2 = move_and_slide(motion2, ground)


func _on_Area2D_area_entered(area):
	if area.is_in_group("attack") and hp > 0:
		area.queue_free()
		being_damaged(1)
		recovery_hit()
		
	if area.is_in_group("attack") and hp <= 0:
		area.queue_free()
		queue_free()
	print("%s_hp: %s" %[$".".name, hp])

func _on_Recover01_timeout():
	$"./Timer".start()

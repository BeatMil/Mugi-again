extends KinematicBody2D

enum {
	IDLE,
	JUMP,
	MOVE,
	MOVE_LEFT,
	RECOVERY_HIT
}
var enum_array = [IDLE,JUMP,MOVE,MOVE_LEFT]
onready var sprite = $"Sprite"
onready var player = get_node("../Player")

# configuration
const SPEED = 100
const JUMP_POWER = 500
var gravity = 10
var hp = 4





var state = JUMP
var motion2 = Vector2()
var direction = 1 # 1 = facing rightc
var ground = Vector2(0,-1)
func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	gravity()
	# print("%s motion2: %s" %[$".".name,motion2])
	if state != RECOVERY_HIT:
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
	# return array[0] or array.front()

func being_damaged(amount):
	hp -= amount

func _on_Timer_timeout():
	change_state_ramdomly(enum_array)

func recovery_hit():
	state = RECOVERY_HIT
	$"./Timer".stop()
	$"./Recover01".start()
	motion2 = Vector2(400 * player.direction,-400)
	motion2 = move_and_slide(motion2, ground)


func _on_Area2D_area_entered(area):
	if area.is_in_group("attack") and hp > 0:
		area.queue_free()
		being_damaged(1)
		recovery_hit()
		
		
	if area.is_in_group("attack") and hp <= 0:
		area.queue_free()
		queue_free()
	print("%s: %s" %[$".".name, hp])

func _on_Recover01_timeout():
	$"./Timer".start()
	pass # Replace with function body.

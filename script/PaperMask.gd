extends KinematicBody2D
#PaperMask.gd
var velocity = Vector2()
var ground = Vector2(0,-1)

var walkSpeed : int = 100
var direction : int = 1 # Facing Right
onready var recovery01_timer = $"recovery01_timer"
onready var state_label = $"state_label"
# onready var attack_hitbox = $"attack_area2D/CollisionShape2D"
onready var player = $"../Player"
enum anum {
	WALK,
	ATTACK,
	RECOVERY
}

onready var state = anum.WALK

func _ready():
	# get_node(".").set_meta("type", "enemy") # set this node tag to enemy
	add_to_group("enemy")
	$Area2D.add_to_group("enemy")
	direction = -1
	

func _physics_process(delta):
#	print($"Area2D".get_overlapping_bodies())
#	for i in $"Area2D".get_overlapping_bodies():
#		print(i.name)
	if state == anum.WALK:
		velocity.y = 100
		if (is_on_floor()):
			velocity.x = walkSpeed * direction
	elif state == anum.ATTACK:
		velocity = Vector2(500 * direction,300)
	elif state == anum.RECOVERY:
		velocity = Vector2(600 * player.direction, -100)
	velocity = move_and_slide(velocity, ground)
	state_label.text = "state: %s"%anum.keys()[state]
	
	


func _on_Area2D_area_entered(area):
	# if area.get_meta("type") == "fireball":
#	print(area.name)
#	print(area.get_groups())
	if area.is_in_group("attack"):
		area.queue_free()
		queue_free()
	elif area.get_parent().is_in_group("player"):
		recovery01_timer.start()
		state = anum.RECOVERY

#		attack_hitbox.disabled = true
#		$Area2D.set_monitoring(false)
#		set_deferred("monitoring",false)
#		print($Area2D.is_monitoring())
		


func _on_attack_area2D_body_entered(body):
#	print(body.get_groups())
	if body.is_in_group("player"):
		state = anum.ATTACK
#		velocity = Vector2(500 * direction,0)

func _on_attack_area2D_body_exited(body):
	if body.is_in_group("player"):
		print("BODY EXIT")
		state = anum.WALK


func _on_recovery01_timer_timeout():
	state = anum.WALK
#	print($attack_area2D.get_overlapping_bodies())
	for i in $attack_area2D.get_overlapping_bodies():
		if i.is_in_group("player"):
			state = anum.ATTACK
#	print($Area2D.get_overlapping_bodies())
	
	recovery01_timer.stop()

extends Area2D

const SPEED = 1500
# onready var player = $"Player"
var velocity = Vector2()
onready var direction = $".."/Player.direction

func _ready():
	# direction = player.direction
	# print("hadoken_direction: %s" % direction)	
	# print("node: %s ready!" % $".".name)
	# print("parent of %s is %s" % [$".".name, get_parent().name])
	# print("parent of %s is %s" % [$".".name, $"..".name])
	# print("parent of %s is %s" % [$".".name, $".."/Player.direction])
	
	$".".set_meta("type", "fireball") # set this node tag to enemy
	add_to_group("attack")
	pass # Replace with function body.
	
func _process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

extends KinematicBody2D
#PaperMask.gd
var velocity = Vector2()
var ground = Vector2(0,-1)

var walkSpeed : int = 100
var direction : int = 1 # Facing Right

func _ready():
	get_node(".").set_meta("type", "enemy") # set this node tag to enemy
	direction = -1
	

func _physics_process(delta):
	velocity.y = 100
	if (is_on_floor()):
		velocity.x = walkSpeed * direction
		
	velocity = move_and_slide(velocity, ground)
	
	

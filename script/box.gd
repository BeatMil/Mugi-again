extends Sprite

var speed = -8

func _physics_process(delta):
	move_local_x(speed)

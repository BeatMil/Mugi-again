extends Sprite

var speed = -8

func _physics_process(_delta):
	move_local_x(speed)

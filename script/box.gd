extends Sprite

var speed = -16

func _physics_process(_delta):
	move_local_x(speed)

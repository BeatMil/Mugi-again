extends Sprite

var speed = -16
var animu_fig = false

func _physics_process(_delta):
	move_local_x(speed)

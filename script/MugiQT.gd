# MugiQT
extends Sprite


func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		self.position.x += 10
	elif Input.is_action_pressed("ui_left"):
		self.position.x -= 10


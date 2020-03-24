extends Sprite
var speed = 16
func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		$Area2D/CollisionShape2D.set_scale(Vector2(0.4,0.4))
		$Area2D/CollisionShape2D.set_position(Vector2(0,100))
	elif Input.is_action_just_released("ui_down"):
		$Area2D/CollisionShape2D.set_scale(Vector2(1,1))
		$Area2D/CollisionShape2D.set_position(Vector2(0,0))
	elif Input.is_action_pressed("ui_right"):
		$".".set_flip_h(false)
		move_local_x(speed)
	elif Input.is_action_pressed("ui_left"):
		$".".set_flip_h(true)
		move_local_x(-speed)
		

extends Sprite
enum anum {
	STOP,
	MOVE,
	ATTACK,
	DIE
}
#signal
signal dead

#config
var speed : int = 15
var direction : int = 1# 1 = facing right
var velocity : Vector2
var on_point : bool = false # shooting
var state

func raycast_check():
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("enemy"):
			on_point = true
		else:
			on_point = false

func move():
	if Input.is_action_pressed("ui_down"):
		$Area2D/CollisionShape2D.set_scale(Vector2(0.5,0.5))
		$Area2D/CollisionShape2D.set_position(Vector2(0,100))
	elif Input.is_action_just_released("ui_down"):
		$Area2D/CollisionShape2D.set_scale(Vector2(1,1))
		$Area2D/CollisionShape2D.set_position(Vector2(0,0))
	elif Input.is_action_pressed("ui_right"):
		set_flip_h(false)
		direction = 1
		move_local_x(speed * direction)
	elif Input.is_action_pressed("ui_left"):
		set_flip_h(true)
		direction = -1
		move_local_x(speed * direction)

func attack():
	pass
		
		
	# up, down movement. I don't want those.
#	if Input.is_action_pressed("ui_up"):
#		move_local_y(-speed)
#	elif Input.is_action_pressed("ui_down"):
#		move_local_y(speed)

func _ready() -> void:
	state = anum.STOP
	$AnimationPlayer.play("idle")

func _physics_process(delta: float) -> void:
	if state != anum.STOP and state != anum.DIE:
		raycast_check() # if enemy is infront, 
		move()


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.name == "hitscan":
#		$Area2D.set_monitoring(false)
#		$Area2D.set_deferred("monitoring",false)
		$Area2D.disconnect("area_entered",self,"_on_Area2D_area_entered")
		$AnimationPlayer.play("die")
		state = anum.DIE


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "die":
		emit_signal("dead")

extends KinematicBody2D
onready var pos1 = get_parent().get_node("pos1").global_position
onready var pos2 = get_parent().get_node("pos2").global_position
#export var pos3 = get_node()
var is_at_pos1 = false
var is_stay = true
var timer_helper = false

func _ready():
	$".".set_global_position(pos1)
#	print($".".global_position)
	pass
	
func _physics_process(delta):
	position_checker()
	if is_at_pos1:
		if timer_helper == false:
			timer_helper = true
			is_stay = true
			$Timer.start()
#		move_and_slide(get_vector(), Vector2.ZERO)
		if !is_stay:
			move_local_x(8)
	elif !is_at_pos1:
		if timer_helper == true:
			timer_helper = false
			is_stay = true
			$Timer.start()
		if !is_stay:
			move_local_x(-8)
		
# get direction for the older method
#func get_vector():
#	return (pos2 - pos1) * 0.2

func position_checker():
	# switch boolean if node is at starting position
	if $".".global_position == pos1:
		is_at_pos1 = true
	if $".".global_position == pos2:
		is_at_pos1 = false


func _on_Timer_timeout():
	print("Timer stop!")
	is_stay = false
	$Timer.stop()

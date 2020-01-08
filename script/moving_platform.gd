extends KinematicBody2D
onready var pos1 = get_parent().get_node("pos1").global_position
onready var pos2 = get_parent().get_node("pos2").global_position
#export var pos3 = get_node()
var is_at_pos1 = true

func _ready():
	$".".set_global_position(pos1)
#	print($".".global_position)
	pass
	
func _physics_process(delta):
	position_checker()
	if is_at_pos1:
#		print("is_at_pos1")
#		move_and_slide(Vector2(100,0), Vector2.ZERO)
		move_and_slide(get_vector(), Vector2.ZERO)
		pass
		
func get_vector():
	return (pos2 - pos1) * 0.2
	pass

func position_checker():
	# switch boolean if node is at starting position
	if $".".global_position == pos1:
		is_at_pos1 = true

	if $".".global_position == pos2:
		is_at_pos1 = false
		
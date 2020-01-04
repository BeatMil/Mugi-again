extends Sprite
onready var pos1 = get_parent().get_node("pos1")
onready var pos2 = get_parent().get_node("pos2")
var is_at_pos1 = true

func _ready():
	$".".set_global_position(pos1.global_position)
	print($".".global_position)
	print(pos1.global_position)
	print("...")

func _physics_process(delta):
	position_checker()
	if is_at_pos1:
		
		pass

func position_checker(): 
	# switch boolean if node is at starting position
	if $".".global_position == pos1.global_position:
		is_at_pos1 = true

	if $".".global_position == pos2.global_position:
		is_at_pos1 = false 
		
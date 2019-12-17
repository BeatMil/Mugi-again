extends Control

var s = {"hadoken":1, "shoryuken":2}
onready var label = get_node("Label")
onready var label2 = get_node("Label2")

enum anum {
	A,
	B,
	C
}
# const bnum = {
# 	IDLE = 0,
# 	AIR = 1,
# 	RECOVERY = 2
# }

var state = anum.A

func _ready():
	print($".".name)
	print(anum)
	print("state: %s"%state)
	print(get_state())

	
	
func _physics_process(delta):
	if Input.is_action_just_pressed("attack02"):
		state = anum.B
		label.text = "Punch"
	elif Input.is_action_just_pressed("ui_accept"):
		state = anum.A
		label.text = "hadoken"
	label2.text = "state: %s"%anum.keys()[state]

func get_state():
	return anum.keys()[state]

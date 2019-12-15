extends Control

var s = {"hadoken":1, "shoryuken":2}
onready var label = get_node("Label")
onready var label2 = get_node("Label2")


const anum = {
	IDLE = 0,
	AIR = 1,
	RECOVERY = 2
}
var state = anum["AIR"]

func _ready():
	print($".".name)
	print(state)
	
	if state == anum["AIR"]:
		print("YAY")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("attack02"):
		label.text = "Punch"
		label2.text = anum.keys()[state]
		print(state)
	elif Input.is_action_just_pressed("ui_accept"):
		label.text = "hadoken"


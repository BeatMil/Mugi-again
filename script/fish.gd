extends Control

var s = {"hadoken":1, "shoryuken":2}
onready var input_window = get_node("input_window")
onready var label = get_node("Label")
onready var label2 = get_node("Label2")
onready var input = get_node("input")
var input_history = []

#const anum = {
#	IDLE = 0,
#	AIR = 1,
#	RECOVERY = 2
#}

enum anum {
	MOVE,
	DASH,
	NOT
}
var state = anum.MOVE

func _ready():
	print($".".name)
#	Input.action_press("ui_accept")
	
func _input(event):
	if event.is_pressed():
		input_history.append(event.as_text())
		print(input_history)
		input.text = str(input_history)


func _physics_process(delta):
	if Input.is_action_just_pressed("attack02"):
		state = anum.MOVE
		label.text = "Punch"
	elif Input.is_action_just_pressed("ui_accept"):
		state = anum.NOT
		label.text = "hadoken"
	elif Input.is_action_pressed("attack02") and Input.is_action_pressed("ui_accept"):
		state = anum.DASH
	label2.text = anum.keys()[state]



func _on__input_window_timeout():
	pass # Replace with function body.

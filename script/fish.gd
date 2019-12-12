extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var s = {"hadoken":1, "shoryuken":2}
onready var label = get_node("Label")
func _ready():
	print($".".name)
#	print(s)
#	print(s["dead"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _physics_process(delta):
	if Input.is_action_just_pressed("attack02"):
		label.text = "Punch"
	elif Input.is_action_just_pressed("ui_accept"):
		label.text = "hadoken"


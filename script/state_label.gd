extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = $"."
onready var player = $".."
onready var velocity = $"velocity"
onready var input = $"input"

func _physics_process(delta):
	label.text = "state: %s" %player.anum.keys()[player.state]
	velocity.text = "velocity: %s"%player.velocity
	input.text = "input: %s"%player.input


extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = $"."
onready var player = $".."
onready var velocity = $"velocity"
onready var input = $"input"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	label.text = "state: %s" %player.anum.keys()[player.state]
	velocity.text = "velocity: %s"%player.velocity
	input.text = "input: %s"%player.input


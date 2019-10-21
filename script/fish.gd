extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var s = {"dead":1, "jump":2}

func _ready():
	print(s)
	print(s["dead"])
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

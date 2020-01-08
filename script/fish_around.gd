extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var num1 = 0
var num2 = 10
var pos1 = Vector2(0,0)
var pos2 = Vector2(100,0)
# Called when the node enters the scene tree for the first time.
func _ready():
#	print(lerp(10, 20, 2))
	pass
	
	
func _physics_process(delta):
	num1 = lerp(num1, num2, 0.75)
#	print(num1)
	var box = lerp(pos1, pos2, 0.75)
	print(box)

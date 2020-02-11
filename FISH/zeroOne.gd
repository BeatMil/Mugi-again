extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_node("Tween")
	tween.set_repeat(true)
	tween.interpolate_property($Sprite, "position",Vector2(-100, -100), Vector2(300, 300),
	1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.interpolate_property($Sprite, "scale",Vector2(1,1),
	Vector2(0.5,0.5), 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.interpolate_property($Sprite, "rotation",0,2, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

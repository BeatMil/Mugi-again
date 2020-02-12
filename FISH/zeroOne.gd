extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = get_node("Tween")

# Called when the node enters the scene tree for the first time.
func _ready():
	tween.set_repeat(true)
	tween.interpolate_property($Sprite, "position",Vector2(-100, -100), Vector2(300, 300),
	1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.interpolate_property($Sprite, "scale",Vector2(1,1),
	Vector2(0.5,0.5), 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.interpolate_property($Sprite, "rotation",0,2, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	print(tween.get_runtime())
	
	tween.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	tween.stop_all()
#	print(tween.tell())
	pass


func _on_LinkButton_button_down():
	OS.shell_open("http://www.google.com")

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print($".".name)
	$AnimationPlayer.play("fade_in")
	
	var tween = get_node("Tween")
#	tween.set_repeat(true)
	tween.interpolate_property($dew, "position",$dew.position,$pos1.position,
	1.9,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _process(delta):
	if $dew.position != $pos1.position:
		$dew/AnimationPlayer.play("walk")
	elif $dew.position == $pos1.position:
		$dew/AnimationPlayer.play("idle")

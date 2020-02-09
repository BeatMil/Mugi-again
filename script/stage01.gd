extends Node2D

const TEXT_ABOVE = preload("res://prefab/text_above.tscn")
const FIREBALL = preload("res://prefab/Player.tscn")

var dialog = ["Ummm....","I'm free now.","So...","Should I go home or go to karate club?"]
var line : int = 0
var switch = true # if line17 helper
var play01 = false

func _ready():
	$AnimationPlayer2.play("fade_in")
	
func _physics_process(_delta):
	if $dew.global_position.x != $pos1.global_position.x and switch:
		$dew.move_local_x(4)
		$dew/AnimationPlayer.play("walk")
	elif $dew.global_position.x == $pos1.global_position.x and switch:
		$dew/AnimationPlayer.play("idle")
		
	if $dew/AnimationPlayer.current_animation == "idle" and switch:
		switch = false
		var text_above = TEXT_ABOVE.instance()
		text_above.set_position($dew.get_global_position() + Vector2(-100,-250))
		$".".add_child(text_above)
		$"text_above".get_child(0).text = dialog[line]
		
	if play01:
		walk()
#		for i in get_children(): # a way to read children
#			print(i.name)
#	if $".".has_node("text_above"):
func walk():
	if Input.is_action_pressed("ui_left"):
		$dew/AnimationPlayer.play("walk")
		$dew.flip_h = true
		$dew.move_local_x(-8)
	elif Input.is_action_pressed("ui_right"):
		$dew/AnimationPlayer.play("walk")
		$dew.flip_h = false
		$dew.move_local_x(8)
	else:
		$dew/AnimationPlayer.play("idle")
func _input(event):
	if !switch and Input.is_key_pressed(KEY_SPACE):
		line += 1
		if line < dialog.size():
			$"text_above".get_child(0).text = dialog[line]
		elif $".".has_node("text_above"):
			play01 = true
			$"text_above".queue_free()

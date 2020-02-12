extends Node2D

const TEXT_ABOVE = preload("res://prefab/text_above.tscn")
var state_walk01 = false
var state_talk01 = false
var state_play01 = false

var sleep = false
var girlfriend = false
var csgo = false
var baito = false

var dialog = ["Tadaimaa","Wait..","I live alone 5555","What should I do?"]
var line : int = 0
func _ready():
	$AnimationPlayer.play("fade_in")
	
	var tween = get_node("Tween")
#	tween.set_repeat(true)
	tween.interpolate_property($dew, "position",$dew.position,$pos1.position,
	1.9,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	state_walk01 = true


func _process(delta):
	if state_walk01:
		if $dew.position != $pos1.position:
			$dew/AnimationPlayer.play("walk")
		elif $dew.position == $pos1.position:
			$dew/AnimationPlayer.play("idle")
			var text_above = TEXT_ABOVE.instance()
			text_above.set_position($dew.get_global_position() + Vector2(-100,-250))
			$".".add_child(text_above)
			$"text_above".get_child(0).text = dialog[line]
			state_walk01 = false
			state_talk01 = true
	if state_talk01:
		pass
		
	if state_play01:
		walk()
		
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
	if state_talk01 and (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_ENTER)):
		line += 1
		if line < dialog.size():
			$"text_above".get_child(0).text = dialog[line]
		elif $".".has_node("text_above"):
			state_talk01 = false
			state_play01 = true
			$"text_above".queue_free()




func _on_sleep_area_entered(area):
	if area.is_in_group("dew"):
		sleep = true
		$dew/dew_label.set_visible(true)
	pass # Replace with function body.


func _on_sleep_area_exited(area):
	if area.is_in_group("dew"):
		sleep = false
		$dew/dew_label.set_visible(false)
	pass # Replace with function body.

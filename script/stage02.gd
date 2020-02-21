extends Node2D

const TEXT_ABOVE = preload("res://prefab/text_above.tscn")
var state_walk01 = false
var state_talk01 = false
var state_play01 = false

var sleep = false
var girlfriend = false
var csgo = false
var baito = false

var shingg01 = load("res://media/Sound/shingg01.wav")
var dialog = ["Tadaimaa","Wait..","I live alone 5555","What should I do?"]
var line : int = 0
func _ready():
	$AnimationPlayer.play("fade_in")
	if get_node("/root/singleton").stage02 == false:
		var tween = get_node("Tween")
	#	tween.set_repeat(true)
		tween.interpolate_property($dew, "position",$dew.position,$pos1.position,
		1.9,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		state_walk01 = true
	else:
		$dew.position = $pos1.position
		state_play01 = true
		$choices.set_visible(true)
		$choices/text_label/sleep.set_monitoring(true)
	$choices/money.set_text("$%s"%$"/root/singleton".money)


func _physics_process(_delta):
	if get_node("/root/singleton").stage02 == false:
		if state_walk01:
			if $dew.position != $pos1.position:
				$dew/AnimationPlayer.play("walk")
			elif $dew.position == $pos1.position:
				$dew/AnimationPlayer.play("idle")
				var text_above = TEXT_ABOVE.instance()
				text_above.set_position($dew.get_global_position() + Vector2(-100,-250))
				$".".add_child(text_above)
				$"text_above".get_child(0).text = dialog[line]
				$"/root/singleton".stage02 = true
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


func _input(_event):
	if state_talk01 and (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_ENTER)):
		line += 1
		if line < dialog.size():
			$"text_above".get_child(0).text = dialog[line]
		elif $".".has_node("text_above"):
			state_talk01 = false
			state_play01 = true
			$"text_above".queue_free()
			$choices.set_visible(true)
			$choices/text_label/sleep.set_monitoring(true)
			
	if Input.is_action_just_pressed("ui_accept") and sleep:
		print("sleep")
	elif Input.is_action_just_pressed("ui_accept") and girlfriend:
		print("gf")
	elif Input.is_action_just_pressed("ui_accept") and csgo:
		print("CSGO!")
	elif Input.is_action_just_pressed("ui_accept") and baito:
		print("baito")
		$dew/VisibilityNotifier2D.disconnect("screen_exited",self,"_on_VisibilityNotifier2D_screen_exited")
		get_tree().change_scene("res://scene/baito_game.tscn")



func _on_sleep_area_entered(area):
	if area.is_in_group("dew"):
		sleep = true
		$dew/dew_label.set_visible(true)


func _on_sleep_area_exited(area):
	if area.is_in_group("dew"):
		sleep = false
		$dew/dew_label.set_visible(false)


func _on_girlfriend_area_entered(area):
	if area.is_in_group("dew"):
		girlfriend = true
		$dew/dew_label.set_visible(true)


func _on_girlfriend_area_exited(area):
	if area.is_in_group("dew"):
		girlfriend = false
		$dew/dew_label.set_visible(false)


func _on_csgo_area_entered(area):
	if area.is_in_group("dew"):
		csgo = true
		$dew/dew_label.set_visible(true)


func _on_csgo_area_exited(area):
	if area.is_in_group("dew"):
		csgo = false
		$dew/dew_label.set_visible(false)


func _on_baito_area_entered(area):
	if area.is_in_group("dew"):
		baito = true
		$dew/dew_label.set_visible(true)

func _on_baito_area_exited(area):
	if area.is_in_group("dew"):
		baito = false
		$dew/dew_label.set_visible(false)


func _on_VisibilityNotifier2D_screen_exited():
	$"/root/SfxBlock".stream = shingg01
	$"/root/SfxBlock".play()
	if $dew.position.x < 0:
		$dew.position.x = 1415
	elif $dew.position.x > 0:
		$dew.position.x = -111


extends Node2D

const TEXT_ABOVE = preload("res://prefab/text_above.tscn")
const FIREBALL = preload("res://prefab/Player.tscn")
const STAGE015 = preload("res://scene/stage01-5.tscn")
const STAGE016 = preload("res://scene/stage01-6.tscn")

var dialog = ["Ummm....","I'm free now.","So...","Should I go home or go to karate club?"]
var line : int = 0
var switch = true # if line17 helper
var play01 = false
var karate = false
var karate02 = false
var go_home = false
var go_home02 = false

func _ready():
	$"/root/singleton".csgo == false
	$"/root/singleton".gf_clear == false
	$"/root/singleton".teddy_bear == false
	$"/root/singleton".csgo_clear == false
	$signs.visible = false
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
	if karate:
		var stage015 = STAGE015.instance()
		stage015.set_position(Vector2.ZERO)
		$".".add_child(stage015)
		karate = false
		karate02 = true
	if karate02:
		if !$".".has_node("stage01-5"):
			$dew.position.x = 400
			$AnimationPlayer2.play("fade_in")
			karate02 = false
			play01 = true
	if go_home:
		var stage016 = STAGE016.instance()
		stage016.set_position(Vector2.ZERO)
		$".".add_child(stage016)
		go_home = false
		go_home02 = true
	if go_home02:
		if !$".".has_node("stage01-6"):
			$AnimationPlayer2.play("fade_in")
			go_home02 = false
			get_tree().change_scene("res://scene/stage02.tscn")
		
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
	if !switch and (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_ENTER)):
		line += 1
		if line < dialog.size():
			$"text_above".get_child(0).text = dialog[line]
		elif $".".has_node("text_above"):
			play01 = true
			$signs.visible = true
			$"text_above".queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	if $dew.position.x < 0:
		play01 = false
		$AnimationPlayer2.play("fade_out")
		karate = true
	elif $dew.position.x > 0:
		play01 = false
		$AnimationPlayer2.play("fade_out")
		go_home = true

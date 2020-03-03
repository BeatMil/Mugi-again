extends Node2D

#cache
const okay_lets_go = preload("res://media/Sound/csgo/csgo/we_kill_them_then_we_go_home.ogg")
const dew_give_me_awp = preload("res://media/Sound/csgo/friends/dew-give-me-awp01.wav")
const DEW_M4 = preload("res://media/Sound/csgo/friends/dew-M4.wav")
const MENU_GUN = preload("res://media/Sound/csgo/csgo/csgo_choosing_gun.ogg")
const M4_START = preload("res://media/Sound/csgo/csgo/m4_start.wav")
const M4_GUN = preload("res://prefab/m4.tscn")

onready var gun_name = get_node("Control/gun_name")

func playsfx(player,sfx):
	player.set_stream(sfx)
	player.play()
	

func _ready() -> void:
	$curtain.set_visible(true)
	$curtain/AnimationPlayer.play("fade_in")
	playsfx($"/root/SfxBlock",okay_lets_go)
	playsfx($"/root/AudioBlock",MENU_GUN)
	if $".".has_node("Control"):
		$Control/revolver.grab_focus()
#		print($Control/revolver.has_focus())

func _input(event: InputEvent) -> void:
	# action release: check for grab focus then play sound
	if event.is_action_released("ui_down") or event.is_action_released("ui_up"):
		if $Control/awp.has_focus():
			playsfx($sfxplayer,dew_give_me_awp)
			gun_name.set_text("AWP")
		elif $Control/m4.has_focus():
			playsfx($sfxplayer,DEW_M4)
			gun_name.set_text("M4")
		elif $Control/revolver.has_focus():
			print("revolver")


func _on_m4_button_down() -> void:
	var dew_m4 = M4_GUN.instance()
	dew_m4.set_position(Vector2(300,-50))
	$dew_csgo.add_child(dew_m4)
	playsfx($"/root/SfxBlock",M4_START)
	$Control.set_visible(false)
	#	tween.set_repeat(true)
	$Tween.interpolate_property($dew_csgo, "position",$dew_csgo.position,$pos1.position,
	2,Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.start()
	$curtain/AnimationPlayer.set_speed_scale(0.3)
	$curtain/AnimationPlayer.play("fade_out")





func _on_curtain_animation_finish(anim) -> void:
	if anim == "fade_out":
		get_tree().change_scene("res://scene/csgo_m4.tscn")

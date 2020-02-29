extends Node2D

#cache
const okay_lets_go = preload("res://media/Sound/csgo/csgo/we_kill_them_then_we_go_home.ogg")
const dew_give_me_awp = preload("res://media/Sound/csgo/friends/dew-give-me-awp01.wav")

func playsfx(player,sfx):
	player.set_stream(sfx)
	player.play()
	

func _ready() -> void:
	playsfx($"/root/SfxBlock",okay_lets_go) 
	if $".".has_node("Control"):
		$Control/revolver.grab_focus()
#		print($Control/revolver.has_focus())

func _input(event: InputEvent) -> void:
	# action release: check for grab focus then play sound
	if event.is_action_released("ui_down") or event.is_action_released("ui_up"):
		if $Control/awp.has_focus():
			playsfx($sfxplayer,dew_give_me_awp)
		elif $Control/mp7.has_focus():
			print("mp7")
		elif $Control/revolver.has_focus():
			print("revolver")

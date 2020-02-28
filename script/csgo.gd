extends Node2D

#cache
const okay_lets_go = preload("res://media/Sound/csgo/csgo/we_kill_them_then_we_go_home.ogg")


func playsfx(player,sfx):
	player.set_stream(sfx)
	player.play()
	

func _ready() -> void:
	playsfx($"/root/SfxBlock",okay_lets_go) 
	if $".".has_node("Control"):
		$Control/revolver.grab_focus()
#		print($Control/revolver.has_focus())

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		print(event.as_text())

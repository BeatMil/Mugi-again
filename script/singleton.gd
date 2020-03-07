extends Node

#player status
var current_hp = 3
var karate_been_to = false
var money : int = 0
var volume = 0
#story progress
var stage02 = false
var teddy_bear = false
var csgo = false
var dev_note = false
var csgo_skip_m4 = false
#story choices
var csgo_clear = false
var gf_clear = false
	
func _process(delta: float) -> void:
	for i in get_tree().current_scene.get_children():
		if i is AudioStreamPlayer:
			i.set_volume_db(volume)
			

func playsfx(player,sfx):
	player.set_stream(sfx)
	player.play()

extends Node

#player status
var current_hp = 3
var karate_been_to = false
var money : int = 1000000
var volume = 0
#story progress
var stage02 = false
var teddy_bear = false
var csgo = false
var dev_note = false
var csgo_skip_m4 = false


func playsfx(player,sfx):
	player.set_stream(sfx)
	player.play()

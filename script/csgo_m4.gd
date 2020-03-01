extends Node2D
# state machine
enum anum {
	TALK,
	PLAY
}
var state

#cache
const HUNK = preload("res://media/Sound/csgo/csgo/hunk.ogg")
onready var root = $"/root/singleton"
onready var root_sfx = $"/root/SfxBlock"
onready var root_ost = $"/root/AudioBlock"



func _ready() -> void:
	state = anum.TALK
	root.playsfx(root_ost,HUNK)
	$AnimationPlayer.play("intro")

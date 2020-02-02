extends AudioStreamPlayer

# onready var player = get_node("../Player")
onready var audio = get_node(".")

# SFX list
var damaged = "res://media/Sound/damaged.ogg"

func _on_Player_damaged():
	audio.stream = load(damaged)
	audio.play()


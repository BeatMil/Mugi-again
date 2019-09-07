extends AudioStreamPlayer

onready var player = get_node("../Player")
onready var audio = get_node(".")
func _ready():
	audio.play()

func play_death_sfx():
	audio.stream = load("res://media/Sound/death01.wav")
	audio.play()
	pass

func _on_Player_dead():
	play_death_sfx()
	pass

extends AudioStreamPlayer

# onready var player = get_node("../Player")
onready var audio = get_node(".")

# song list
var death01 = "res://media/Sound/death01.wav"
var rabi_ribi_ost = "res://media/Sound/rabi ribi park original.ogg"

func _ready():
	audio.stream = load(rabi_ribi_ost)
	# audio.play()

func _on_Player_dead():
	audio.stream = load(death01)
	audio.play()
	


extends Node2D
const IDLE_DURATION = 1.0
export var move_to = Vector2.RIGHT * 192
export var speed = 3.0
onready var platform = get_node("platform")
onready var tween = get_node("tween")

func _ready():
	_init_tween()

func _init_tween():
#	var duration = move_to.length() / float(speed * Globals.UNIT_SIZE)
	pass
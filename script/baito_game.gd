extends Node2D

var animu_goods = ["kazuma","megumin","aqua"]
var time_waits = [0.8,1.2,1.6,1.8,2.2,2.6]
const BOX = preload("res://prefab/box.tscn")


var on_point = false


func _ready():
	$Timer.start()
	pass # Replace with function body.

func _physics_process(delta):
	pass


func _on_Timer_timeout():
	var box = BOX.instance()
	box.set_position($figa_spawner.get_position())
	$".".add_child(box)
	time_waits.shuffle()
	$Timer.set_wait_time(time_waits[0])

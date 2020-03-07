extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var go_up = false
export var speed = 5

func _physics_process(delta: float) -> void:
	if go_up == true:
		get_node(".").move_local_y(-speed)

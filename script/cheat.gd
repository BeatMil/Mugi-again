extends Node2D

func _ready():
    pass

func _input(event):
    if Input.is_key_pressed(KEY_R):
        print(get_tree().change_scene('res://scene/stage01.tscn'))
    
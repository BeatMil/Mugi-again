extends Control
func _ready():
	get_node("VBoxContainer/Button").grab_focus()
	
func _on_Button_pressed():
	get_tree().change_scene("res://scene/stage01.tscn")

func _on_Button2_pressed():
	get_tree().quit()

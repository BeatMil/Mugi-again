extends Node2D

func _ready() -> void:
	load_text_file()
	
func load_text_file():
	var f = File.new()
	f.open("res://script/mugi_dialog.txt", File.READ)
	var text = f.get_as_text()
	var array_text = text.split("\n")
	print(array_text)

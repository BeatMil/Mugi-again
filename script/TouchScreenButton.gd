extends TouchScreenButton
# TouchScreenButton

func _ready():
	print($".".name)
	print(get_node("../Player").name)
	get_node("../Player").sayWord("Kawaii janai")
	pass
	



func _on_TouchScreenButton_pressed():
	print("touch!")
	get_node("../Player").sayWord("Kawaii janai")
	pass # Replace with function body.

extends Polygon2D

var dialog = ["Hey dew!","Lets play CSGO!","one more seat for you!"]

onready var text = $text
var line : int = 0
func _ready():
	text.set_visible_characters(0)
	text.set_text(dialog[line])
	print(dialog.size())
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		text.visible_characters = 0
		if line < dialog.size() - 1:
			line += 1
		else:
			queue_free()
		text.text = dialog[line]
		$Timer.start()
	pass
#func _process(delta):
#	pass


func _on_Timer_timeout(): # Make text slowly appear (typing appear)
	text.visible_characters += 1
	if text.get_visible_characters() == dialog[line].length():
		print("timer stop!")
		print(dialog[line].length())
		$Timer.stop()
	pass # Replace with function body.

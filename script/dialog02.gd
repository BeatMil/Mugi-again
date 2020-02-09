extends Polygon2D

var dialog = ["Mukashi Mukashi...","There is a main protagonist name Dew."
,"He has the biggest dong and the most handsome face in the world.","But, even him!","has to choose between difficult choices in his life."]

var start_song = "res://media/Sound/village_velder.ogg"
onready var text = $text
var line : int = 0
func _ready():
	$"/root/AudioBlock".stream = load(start_song)
	$"/root/AudioBlock".play()
	text.set_visible_characters(0)
	text.set_text(dialog[line])

func _input(event):
	if event.is_action_pressed("ui_accept"):
		text.visible_characters = 0
		if line < dialog.size() - 1:
			line += 1
		else:
			queue_free()
			# sfx makes it lose the atmosphere
#			$"/root/SfxBlock".stream = load("res://media/Sound/menu_confirm.wav")
#			$"/root/SfxBlock".play()
			get_tree().change_scene("res://scene/stage01.tscn")
		text.text = dialog[line]
		$Timer.start()


func _on_Timer_timeout(): # Make text slowly appear (typing appear)
	text.visible_characters += 1
	if text.get_visible_characters() == dialog[line].length():
		$Timer.stop()

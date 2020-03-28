extends Polygon2D

#var dialog = ["Mukashi Mukashi...","There is a main protagonist name Dew."
#,"He has the biggest dong and the most handsome face in the world.","But, even him!","has to choose between difficult choices in his life."]

var dialogs : Array = []

onready var text = $text
var line : int = 0
func _ready():
	load_text_file()
	text.set_visible_characters(0)
	text.set_text(dialogs[line])

func _input(event):
	if event.is_action_pressed("ui_accept"):
		text.visible_characters = 0
		if line < dialogs.size() - 1:
			line += 1
		else:
			queue_free()
			# sfx makes it lose the atmosphere
#			$"/root/SfxBlock".stream = load("res://media/Sound/menu_confirm.wav")
#			$"/root/SfxBlock".play()
			if get_parent().name == "intro_dialog":
				get_tree().change_scene("res://scene/stage01.tscn")
			elif get_parent().name == "stage01-5" or get_parent().name == "stage01-6":
				get_parent().queue_free()
		text.text = dialogs[line]
		$Timer.start()


func _on_Timer_timeout(): # Make text slowly appear (typing appear)
	text.visible_characters += 1
	if text.get_visible_characters() == dialogs[line].length():
		$Timer.stop()
		
func load_text_file():
	var f = File.new()
	f.open("res://script/mugi_dialog.gd", File.READ)
	var text = f.get_as_text()
	dialogs = text.split("\n")

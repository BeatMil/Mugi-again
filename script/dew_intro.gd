extends Control



var rabi_ribi_ost = "res://media/Sound/rabi ribi park original.ogg"
var menu_confirm = "res://media/Sound/menu_confirm.wav"
func _ready():
#	$Button.grab_click_focus()
	$AnimationPlayer.play("text_big_small")
	$AnimationPlayer2.play("dew_logo")
	$AnimationPlayer3.play("flash_white")
	$"/root/AudioBlock".play()
#	print(singleton.player_name)
#	print($"/root".name)
#	print($".".name)
func _process(delta):
	$"/root/AudioBlock".volume_db = $VSlider.value

func _input(event):
#	if event:
#		print(event.as_text())
#	if event.as_text() == "Escape":
#		get_tree().quit()
		
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	elif Input.is_key_pressed(KEY_SPACE):
		$"/root/SfxBlock".set_stream(load(menu_confirm))
		$"/root/SfxBlock".play()
		$"/root/AudioBlock".stop()
		get_tree().change_scene("res://scene/intro_dialog.tscn")
		



func _on_Timer_timeout(): 
	$VSlider.visible = true
	$Button.set_visible(true)
	$esc.set_visible(true)
	$AnimationPlayer2.play("dew_logo_flash")
	$free_colorRect.start()


func _on_free_colorRect_timeout():
	$ColorRect.queue_free()
	$free_colorRect.stop()
	$VSlider.grab_focus()

extends Node2D
const SAYONARA = preload("res://media/Sound/end/Sayo-nara.ogg")
var space : int = 0 # the amount of space button press
func _ready() -> void:
	$curtain.set_visible(true)
	$"/root/singleton".playsfx($"/root/AudioBlock",SAYONARA)
	if $"/root/singleton".gf_clear == false:
		$"/root/singleton".gf_clear = true
	$curtain/AnimationPlayer.play("fade_in")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		space += 1 # count space button
		if space == 2: # if space has been press 2 times
			$Sprite.set_texture(preload("res://media/ENDINGS/senko-ending02.png")) # change sprite to senko aqua
			$Sprite.set_scale(Vector2(0.5,0.5))
		elif space == 3: # if space has been press 3 times
			$AnimationPlayer.play("fade_away")
			

func _on_textPolygon_tree_exited() -> void:
	$curtain/AnimationPlayer.play("fade_out")
	$Timer.start()

func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://scene/stage02.tscn")

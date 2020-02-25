extends Control

var INSULT_ORDER = preload("res://media/Sound/insult_order.ogg")
var WELCOME = preload("res://media/Sound/merchant/merchat_welcome.wav")
var NOT_ENOUGH_CASH = preload("res://media/Sound/merchant/merchat_not_enough.wav")
var COME_BACK = preload("res://media/Sound/merchant/merchat_come_back.wav")
var AWESOME = preload("res://media/Sound/merchant/merchat_awesome_choice.wav")
var KACHING = preload("res://media/Sound/kaching.wav")

func _ready() -> void:
	$curtain/AnimationPlayer.play("fade_in")
	$AnimationPlayer.play("money_shine")
	$AnimatedSprite.play("idle")
	$teddy_bear.grab_focus()
	$money.text = "$%s"%$"/root/singleton".money
	$"/root/AudioBlock".set_stream(INSULT_ORDER)
	$"/root/AudioBlock".play()
	$"/root/SfxBlock".set_stream(WELCOME)
	$"/root/SfxBlock".play()

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		$"/root/SfxBlock".set_stream(COME_BACK)
		$"/root/SfxBlock".play()
		$curtain/AnimationPlayer.play("fade_out")




func _on_curtain_animation_finish(anim_name) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene("res://scene/stage02.tscn")


func _on_teddy_bear_pressed() -> void:
	if $"/root/singleton".money < 2000:
		$"/root/SfxBlock".set_stream(NOT_ENOUGH_CASH)
		$"/root/SfxBlock".play()
	else:
		$"/root/singleton".money -= 2000
		$money.text = "$%s"%$"/root/singleton".money
		$"/root/SfxBlock".set_stream(AWESOME)
		$"/root/SfxBlock".play()
		$AudioStreamPlayer.set_stream(KACHING)
		$AudioStreamPlayer.play()
		
	if $"/root/singleton".money <= 0:
		$AnimationPlayer.play("money_zero")
	else:
		$AnimationPlayer.play("money_shine")

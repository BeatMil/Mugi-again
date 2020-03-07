extends Control

var INSULT_ORDER = preload("res://media/Sound/insult_order.ogg")
var WELCOME = preload("res://media/Sound/merchant/merchat_welcome.wav")
var NOT_ENOUGH_CASH = preload("res://media/Sound/merchant/merchat_not_enough.wav")
var COME_BACK = preload("res://media/Sound/merchant/merchat_come_back.wav")
var AWESOME = preload("res://media/Sound/merchant/merchat_awesome_choice.wav")
var KACHING = preload("res://media/Sound/kaching.wav")

#config
var teddy_bear_price = 1000
var laptop_price = 3000
var dev_note_price = 100000

func _ready() -> void:
	if $"/root/singleton".csgo:
		$laptop/Label.text = "NEW LAPTOP SOLD"
		$laptop/Label.set_modulate(Color(0.35, 0.35, 0.35))
		$laptop.set_disabled(true)
	if $"/root/singleton".teddy_bear:
		$teddy_bear/Label.text = "TEDDY BEAR SOLD"
		$teddy_bear/Label.set_modulate(Color(0.35, 0.35, 0.35))
		$teddy_bear.set_disabled(true)
	if $"/root/singleton".dev_note:
		$dev_note/Label.text = "DEV NOTE SOLD"
		$dev_note/Label.set_modulate(Color(0.35, 0.35, 0.35))
		$dev_note.set_disabled(true)
	$curtain.set_visible(true)
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
	if $"/root/singleton".money < teddy_bear_price:
		$"/root/SfxBlock".set_stream(NOT_ENOUGH_CASH)
		$"/root/SfxBlock".play()
	else:
		$"/root/singleton".money -= teddy_bear_price
		$money_down.text = "-$%s"%teddy_bear_price
		$AnimationPlayer2.play("money_down")
		$money.text = "$%s"%$"/root/singleton".money
		$"/root/SfxBlock".set_stream(AWESOME)
		$"/root/SfxBlock".play()
		$AudioStreamPlayer.set_stream(KACHING)
		$AudioStreamPlayer.play()
		$teddy_bear/Label.text = "TEDDY BEAR SOLD"
		$teddy_bear/Label.set_modulate(Color(0.35, 0.35, 0.35))
		$teddy_bear.set_disabled(true)
		$"/root/singleton".teddy_bear = true
		
	if $"/root/singleton".money <= 0:
		$AnimationPlayer.play("money_zero")
	else:
		$AnimationPlayer.play("money_shine")


func _on_laptop_pressed() -> void:
	if $"/root/singleton".money < laptop_price:
		$"/root/SfxBlock".set_stream(NOT_ENOUGH_CASH)
		$"/root/SfxBlock".play()
	else:
		$"/root/singleton".money -= laptop_price
		$money_down.text = "-$%s"%laptop_price
		$AnimationPlayer2.play("money_down")
		$money.text = "$%s"%$"/root/singleton".money
		$"/root/SfxBlock".set_stream(AWESOME)
		$"/root/SfxBlock".play()
		$AudioStreamPlayer.set_stream(KACHING)
		$AudioStreamPlayer.play()
		$"/root/singleton".csgo = true
		$laptop/Label.text = "NEW LAPTOP SOLD"
		$laptop/Label.set_modulate(Color(0.35, 0.35, 0.35))
		$laptop.set_disabled(true)
		
	if $"/root/singleton".money <= 0:
		$AnimationPlayer.play("money_zero")
	else:
		$AnimationPlayer.play("money_shine")


func _on_dev_note_pressed() -> void:
	if $"/root/singleton".money < dev_note_price:
		$"/root/SfxBlock".set_stream(NOT_ENOUGH_CASH)
		$"/root/SfxBlock".play()
	else:
		$"/root/singleton".money -= dev_note_price
		$money_down.text = "-$%s"%dev_note_price
		$AnimationPlayer2.play("money_down")
		$money.text = "$%s"%$"/root/singleton".money
		$"/root/SfxBlock".set_stream(AWESOME)
		$"/root/SfxBlock".play()
		$AudioStreamPlayer.set_stream(KACHING)
		$AudioStreamPlayer.play()
		$"/root/singleton".dev_note = true
		$dev_note/Label.text = "DEV NOTE SOLD"
		$dev_note/Label.set_modulate(Color(0.35, 0.35, 0.35))
		$dev_note.set_disabled(true)
		
	if $"/root/singleton".money <= 0:
		$AnimationPlayer.play("money_zero")
	else:
		$AnimationPlayer.play("money_shine")

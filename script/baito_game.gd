extends Node2D

var animu_goods = ["kazuma","megumin","aqua"]

const FIG = preload("res://prefab/animu_fig.tscn")

var time_waits = [0.4,0.8,1.2,1.6]
const BOX = preload("res://prefab/box.tscn")
onready var score_text = $CanvasLayer/score
var score : int = 0

var on_box # area2D of the box
var on_point = false
var freak_out = false
var put_down = false
var result = false

# sound path
var star01 = preload("res://media/Sound/kirby/star01.wav")
var collect01 = preload("res://media/Sound/kirby/collect01.wav")
var inside_UPRPRC = preload("res://media/Sound/Inside UPRPRC_cut.ogg")
var crab_rave = preload("res://media/Sound/Crab_Rave_lower_version.ogg")
var KAZUMA_DROP = preload("res://media/Sound/baito_game/kazuma_drop.wav")
var KAZUMA_IN_BOX = preload("res://media/Sound/baito_game/kazuma_in_box.wav")
var MEGUMIN_DROP = preload("res://media/Sound/baito_game/megumin_drop.wav")
var MEGUMIN_IN_BOX = preload("res://media/Sound/baito_game/megumin_in_box.wav")
var AQUA_DROP = preload("res://media/Sound/baito_game/aqua_drop.wav")
var AQUA_IN_BOX = preload("res://media/Sound/baito_game/aqau_in_box.wav")
var SENKO_DROP = preload("res://media/Sound/baito_game/senko_drop.wav")
var SENKO_IN_BOX = preload("res://media/Sound/baito_game/senko_in_box.wav")
var SHIRO_DROP = preload("res://media/Sound/baito_game/shiro_drop.wav")
var SHIRO_IN_BOX = preload("res://media/Sound/baito_game/shiro_in_box.wav")
var DIO_DROP = preload("res://media/Sound/baito_game/dio_drop.wav")
var DIO_IN_BOX = preload("res://media/Sound/baito_game/dio_in_box.wav")
var RANKA_DROP = preload("res://media/Sound/baito_game/ranka_drop.wav")
var RANKA_IN_BOX = preload("res://media/Sound/baito_game/ranka_in_box.wav")
var MAIKA_DROP = preload("res://media/Sound/baito_game/maika_drop.wav")
var MAIKA_IN_BOX = preload("res://media/Sound/baito_game/maika_in_box.wav")

func _ready():
	$dew_baito/AnimationPlayer.play("carry")
	$fade.set_visible(true)
	$AnimationPlayer2.play("fade_in")
	$tutorial_pause.set_visible(true)
	get_tree().set_pause(true)
	randomize()
	fig_spawn($fig_spawner.position,Vector2(0.5,0.5),-90)
	$box_timer.start()
	score_text.text = "0"
	$sfxblock.set_volume_db($"/root/singleton".volume)
	$"/root/AudioBlock".set_volume_db($"/root/singleton".volume - 5)
	$"/root/AudioBlock".set_stream(inside_UPRPRC)
	$"/root/AudioBlock".play()
	# print list of nodes
#	for i in get_node(".").get_children():
#		print(i.name)
	
	
#func _physics_process(delta):
#	pass

func _input(_event):

	if Input.is_action_just_pressed("ui_accept") and on_point and !freak_out and !result and !put_down:
		$dew_baito/put_down_timer.start()
		$dew_baito/AnimationPlayer.play("put_down")
#		$sfxblock.set_stream(collect01)
#		$sfxblock.play()
		add_money(100)
		$AnimationPlayer.play("money_up")
		put_down = true
		#destroying fig node
#		get_node("@box@2").queue_free()  #new name for the newly spawn same name node
		if $".".has_node("animu_fig"):
			check_fig_and_play_sound(false)
			# I was trying to move the animu_fig node to be child node of the box
			# but it didn't work so I change the way
			# I instance animu_fig as a child node of the box but change it's texture instead 555
			on_box.get_parent().animu_fig = true
			var texture = get_node("animu_fig").get_texture()
			get_node("animu_fig").queue_free()
			var animu = FIG.instance()
			animu.set_z_index(-1)
			on_box.get_parent().add_child(animu)
			animu.beat_set_texture(texture)
	elif Input.is_action_just_pressed("ui_accept") and !on_point and !freak_out and !result and !put_down:
		add_money(-100)
		$AnimationPlayer.play("money_down")
		$dew_baito/AnimationPlayer.play("freak_out")
#		$sfxblock.set_stream(star01)
#		$sfxblock.play()
		freak_out = true
		$dew_baito/freak_out_timer.start()
		if $".".has_node("animu_fig"):
			check_fig_and_play_sound(true)
			get_node("animu_fig").disappear()
	elif Input.is_key_pressed(KEY_ESCAPE) and !result:
		$dew_baito/freak_out_timer.stop()
		$dew_baito/put_down_timer.stop()
		result = true
		$border_check.set_monitoring(false)
		$ColorRect/result_money.set_text("You got\n$%s"%score)
		$"/root/singleton".money += score
		$box_timer.stop()
		$AnimationPlayer.play("result_down")
		$AnimationPlayer2.play("money_shine")
		$"/root/AudioBlock".set_stream(crab_rave)
		$"/root/AudioBlock".play()
		$dew_baito/AnimationPlayer.play("dance")
	elif Input.is_key_pressed(KEY_ESCAPE) and result:
		$AnimationPlayer.play("fade_out")
	
func check_fig_and_play_sound(drop : bool):
	var fig_path = get_node("animu_fig").get_texture().get_load_path().substr(14,14)
	if fig_path.find("aqua") >= 0 and drop:
		$sfxblock.set_stream(AQUA_DROP)
		$sfxblock.play()
	elif fig_path.find("kazuma") >= 0 and drop:
		$sfxblock.set_stream(KAZUMA_DROP)
		$sfxblock.play()
	elif fig_path.find("megumin") >= 0 and drop:
		$sfxblock.set_stream(MEGUMIN_DROP)
		$sfxblock.play()
	elif fig_path.find("senko") >= 0 and drop:
		$sfxblock.set_stream(SENKO_DROP)
		$sfxblock.play()
	elif fig_path.find("dio") >= 0 and drop:
		$sfxblock.set_stream(DIO_DROP)
		$sfxblock.play()
	elif fig_path.find("shiro") >= 0 and drop:
		$sfxblock.set_stream(SHIRO_DROP)
		$sfxblock.play()
	elif fig_path.find("shiro") >= 0 and !drop:
		$sfxblock.set_stream(SHIRO_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("ranka") >= 0 and drop:
		$sfxblock.set_stream(RANKA_DROP)
		$sfxblock.play()
	elif fig_path.find("ranka") >= 0 and !drop:
		$sfxblock.set_stream(RANKA_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("maika") >= 0 and drop:
		$sfxblock.set_stream(MAIKA_DROP)
		$sfxblock.play()
	elif fig_path.find("maika") >= 0 and !drop:
		$sfxblock.set_stream(MAIKA_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("dio") >= 0 and !drop:
		$sfxblock.set_stream(DIO_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("aqua") >= 0 and !drop:
		$sfxblock.set_stream(AQUA_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("kazuma") >= 0 and !drop:
		$sfxblock.set_stream(KAZUMA_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("megumin") >= 0 and !drop:
		$sfxblock.set_stream(MEGUMIN_IN_BOX)
		$sfxblock.play()
	elif fig_path.find("senko") >= 0 and !drop:
		$sfxblock.set_stream(SENKO_IN_BOX)
		$sfxblock.play()

func add_money(amount):
	score += amount
	score_text.text = str(score)

func fig_spawn(position,scale,rotation):
	if $".".has_node("animu_fig"):
		get_node("animu_fig").queue_free()
	if $".".has_node("@animu_fig@2"):
		get_node("@animu_fig@2").queue_free()
	if $".".has_node("@animu_fig@3"):
		get_node("@animu_fig@3").queue_free()
	
	var fig = FIG.instance()
	fig.set_scale(scale)
	fig.set_z_index(-2)
	fig.set_rotation_degrees(rotation)
	fig.set_position(position)
	$".".add_child(fig)
	
func _on_box_timer_timeout():
	var box = BOX.instance()
	box.set_z_index(-2)
	box.set_z_index(-2)
	box.set_position($box_spawner.get_position())
	$".".add_child(box)
	time_waits.shuffle()
	$box_timer.set_wait_time(time_waits[0])


func _on_dew_area2d_area_entered(area):
	if area.is_in_group("box"):
		on_point = true
		on_box = area


func _on_dew_area2d_area_exited(area):
	if area.is_in_group("box"):
		on_point = false
		on_box = null


func _on_freak_out_timer_timeout():
	freak_out = false
	fig_spawn($fig_spawner.position,Vector2(0.5,0.5),-90)
	$dew_baito/AnimationPlayer.play("carry")
	$dew_baito/freak_out_timer.stop()
		


func _on_put_down_timer_timeout():
	put_down = false
	fig_spawn($fig_spawner.position,Vector2(0.5,0.5),-90)
	$dew_baito/AnimationPlayer.play("carry")
	$dew_baito/put_down_timer.stop()





func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene("res://scene/stage02.tscn")


func _on_border_check_area_entered(area):
	if !area.get_parent().animu_fig and !put_down:
		if $".".has_node("animu_fig"):
			check_fig_and_play_sound(true)
			# if two boxes go out of stage together bug would occur
		add_money(-100)
		$AnimationPlayer.play("money_down")
		$dew_baito/AnimationPlayer.play("freak_out")
#		$sfxblock.set_stream(star01)
#		$sfxblock.play()
		freak_out = true
		$dew_baito/freak_out_timer.start()
		if $".".has_node("animu_fig"):
			get_node("animu_fig").disappear()
	area.get_parent().queue_free()
	

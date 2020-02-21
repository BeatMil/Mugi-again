extends Node2D

var animu_goods = ["kazuma","megumin","aqua"]

const FIG = preload("res://prefab/animu_fig.tscn")

var time_waits = [0.4,0.8,1.2,1.6]
const BOX = preload("res://prefab/box.tscn")
onready var score_text = $CanvasLayer/score
var score : int = 0

var on_box
var on_point = false
var freak_out = false
var put_down = false
var result = false

var star01 = preload("res://media/Sound/kirby/star01.wav")
var collect01 = preload("res://media/Sound/kirby/collect01.wav")
var inside_UPRPRC = preload("res://media/Sound/Inside UPRPRC_cut.ogg")
var crab_rave = preload("res://media/Sound/Crab_Rave.wav")

func _ready():
	randomize()
	fig_spawn($fig_spawner.position,Vector2(0.5,0.5),-90)
	$box_timer.start()
	score_text.text = "0"
	$sfxblock.set_volume_db($"/root/singleton".volume)
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
		$sfxblock.set_stream(collect01)
		$sfxblock.play()
		add_money(100)
		$AnimationPlayer.play("money_up")
		put_down = true
		#destroying fig node
#		get_node("@box@2").queue_free()  #new name for the newly spawn same name node
		if $".".has_node("animu_fig"):
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
		$sfxblock.set_stream(star01)
		$sfxblock.play()
		freak_out = true
		$dew_baito/freak_out_timer.start()
		if $".".has_node("animu_fig"):
			get_node("animu_fig").disappear()
	elif Input.is_key_pressed(KEY_ESCAPE) and !result:
		result = true
		$ColorRect/result_money.set_text("You got\n$%s"%score)
		$"/root/singleton".money += score
		$box_timer.stop()
		$AnimationPlayer.play("result_down")
		$AnimationPlayer2.play("money_shine")
		$"/root/AudioBlock".set_stream(crab_rave)
		$"/root/AudioBlock".play()
	elif Input.is_key_pressed(KEY_ESCAPE) and result:
		$AnimationPlayer.play("fade_out")
	

func add_money(amount):
	score += amount
	score_text.text = str(score)

func fig_spawn(position,scale,rotation):
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
	fig_spawn($fig_spawner.position,Vector2(0.5,0.5),-90)
	$dew_baito/AnimationPlayer.play("carry")
	$dew_baito/put_down_timer.stop()
	put_down = false





func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene("res://scene/stage02.tscn")

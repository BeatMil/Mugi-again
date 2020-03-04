extends Node2D
# state machine
enum anum {
	TALK,
	PLAY
}
var state



#cache
const HUNK = preload("res://media/Sound/csgo/csgo/hunk.ogg")
const ENCOUNTER = preload("res://media/Sound/csgo/csgo/Metal_Gear_Solid_OST_Encounter.ogg")
const UHH = preload("res://media/Sound/csgo/friends/dew-auuhhu01.wav")
onready var root = $"/root/singleton"
onready var root_sfx = $"/root/SfxBlock"
onready var root_ost = $"/root/AudioBlock"




func _ready() -> void:
	get_node("enemy_ct2/VisibilityNotifier2D").disconnect("screen_entered",get_node("enemy_ct2"),"_on_VisibilityNotifier2D_screen_entered")
	get_node("enemy_ct3/VisibilityNotifier2D").disconnect("screen_entered",get_node("enemy_ct3"),"_on_VisibilityNotifier2D_screen_entered")
	$event/event_back_block.set_monitoring(false)
	$CanvasLayer/skip.set_visible(false)
	if $"/root/singleton".csgo_skip_m4 == true:
		$CanvasLayer/skip.set_visible(true)
	if $"/root/singleton".csgo_skip_m4 == false:
		$"/root/singleton".csgo_skip_m4 = true
	$CanvasLayer/curtain.set_visible(true)
	state = anum.TALK
	root.playsfx(root_ost,ENCOUNTER)
	$CanvasLayer/curtain/AnimationPlayer.play("fade_in")
	$AnimationPlayer.play("intro")
	$CanvasLayer/tutorial.set_visible(false)

func _physics_process(delta: float) -> void:
	if state == anum.TALK: 
		if Input.is_action_just_pressed("ui_accept"): # skip button
			$CanvasLayer/skip.set_visible(false)
			$AnimationPlayer.seek(30)
			# first move
			$CanvasLayer/tutorial.set_visible(true)
			state = anum.PLAY
#			$dew_csgo.state = $dew_csgo.anum.MOVE
			$timer_skip.start()
			$dew_csgo/Camera2D.current = true
			

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "intro":
		# first move
		$CanvasLayer/tutorial.set_visible(true)
		state = anum.PLAY
		$dew_csgo.state = $dew_csgo.anum.MOVE
		$dew_csgo/Camera2D.current = true
		$CanvasLayer/skip.set_visible(false)
		$event/event_back_block.set_monitoring(true)
	elif anim_name == "event05":
		$AnimationPlayer.play("event06")


func _on_event01_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$AnimationPlayer.play("bill_event01")
		$CanvasLayer/tutorial.set_visible(false)
		$event/event01.queue_free()


func _on_dew_csgo_dead() -> void:
	$CanvasLayer/curtain/AnimationPlayer.play("fade_out")
	pass


func _on_curtain_animation_finish(anim) -> void:
	if anim == "fade_out":
		get_tree().change_scene("res://scene/csgo.tscn")


func _on_timer_skip_timeout() -> void:
	$dew_csgo.state = $dew_csgo.anum.MOVE


func _on_event_back_block_area_entered(area: Area2D) -> void:
	area.get_parent().move_local_x(300)
	if area.is_in_group("dew"):
		$"/root/singleton".playsfx($sfx,UHH)


func _on_event02_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$AnimationPlayer.play("dew_event01")
		$event/event02.queue_free()


func _on_event03_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$AnimationPlayer.play("event03")
		$event/event03.queue_free()


func _on_event01_5_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$AnimationPlayer.play("event01_5")
		$event/event01_5.queue_free()


func _on_event04_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		get_node("enemy_ct2/AnimationPlayer").play("hide")
		$event/event04.queue_free()


func _on_event05_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$event/event_back_block.set_position($event/event05.get_position() + Vector2(-200,0))
		$AnimationPlayer.play("event05")
		$event/event05.queue_free()


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$AnimationPlayer.play("event_awp")


func _on_event07_area_entered(area: Area2D) -> void:
	$enemy_ct3/AnimationPlayer.play("hide")
	$event/event07.queue_free()


func _on_timer_dead_timeout() -> void:
	get_tree().change_scene("res://scene/csgo.tscn")

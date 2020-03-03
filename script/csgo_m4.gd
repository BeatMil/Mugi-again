extends Node2D
# state machine
enum anum {
	TALK,
	PLAY
}
var state



#cache
const HUNK = preload("res://media/Sound/csgo/csgo/hunk.ogg")
onready var root = $"/root/singleton"
onready var root_sfx = $"/root/SfxBlock"
onready var root_ost = $"/root/AudioBlock"



func _ready() -> void:
	$CanvasLayer/skip.set_visible(false)
	if $"/root/singleton".csgo_skip_m4 == true:
		$CanvasLayer/skip.set_visible(true)
	if $"/root/singleton".csgo_skip_m4 == false:
		$"/root/singleton".csgo_skip_m4 = true
	$CanvasLayer/curtain.set_visible(true)
	state = anum.TALK
	root.playsfx(root_ost,HUNK)
	$CanvasLayer/curtain/AnimationPlayer.play("fade_in")
	$AnimationPlayer.play("intro")
	$CanvasLayer/tutorial.set_visible(false)

func _physics_process(delta: float) -> void:
	if state == anum.TALK:
		if Input.is_action_just_pressed("ui_accept"):
			$CanvasLayer/skip.set_visible(false)
			$AnimationPlayer.seek(5)
			# first move
			$CanvasLayer/tutorial.set_visible(true)
			state = anum.PLAY
			$dew_csgo.state = $dew_csgo.anum.MOVE
			$dew_csgo/Camera2D.current = true
			
	pass

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "intro":
		# first move
		$CanvasLayer/tutorial.set_visible(true)
		state = anum.PLAY
		$dew_csgo.state = $dew_csgo.anum.MOVE
		$dew_csgo/Camera2D.current = true


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

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
	state = anum.TALK
	root.playsfx(root_ost,HUNK)
	$AnimationPlayer.play("intro")
	$CanvasLayer/tutorial.set_visible(false)

func _physics_process(delta: float) -> void:
	pass

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "intro":
		$CanvasLayer/tutorial.set_visible(true)
		state = anum.PLAY
		$dew_csgo.state = $dew_csgo.anum.MOVE
		$dew_csgo/Camera2D.current = true


func _on_event01_area_entered(area: Area2D) -> void:
	if area.is_in_group("dew"):
		$AnimationPlayer.play("bill_event01")
		$CanvasLayer/tutorial.set_visible(false)
		$event/event01.queue_free()

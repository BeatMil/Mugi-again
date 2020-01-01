extends Sprite

const PAPERMASK = preload("res://prefab/PaperMask02.tscn")
onready var pos = $"Position2D"

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	var papermask = PAPERMASK.instance()
	papermask.set_position(pos.get_global_position())
	$"..".add_child(papermask)
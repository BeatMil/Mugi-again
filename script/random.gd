extends Node2D




func _ready() -> void:
	randomize()
	print(10%2)

	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
#		print(randi()%11)
		print(int(rand_range(0,11)))

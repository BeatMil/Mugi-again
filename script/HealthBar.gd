extends Control

onready var health_bar = $TextureProgress
onready var health_num = $HealthNum

var max_hp
var hp


func _ready():
	max_hp = get_parent().hp_max
#	hp = max_hp
	hp = $"/root/singleton".current_hp
	health_num.text = String(hp)
	health_bar.set_tint_progress(Color(0, 1, 0))
	var remain_hp = (hp/max_hp) * 100
	health_bar.value = remain_hp 
	health_num.text = String(hp)
	if hp == 3:
		health_bar.set_tint_progress(Color(1, 1, 0))
	elif hp == 2:
		health_bar.set_tint_progress(Color(1, 0.5, 0))
	elif hp == 1:
		health_bar.set_tint_progress(Color(1, 0, 0))
	elif hp <= 4:
		health_bar.set_tint_progress(Color(0,1,0))
	pass

func health_decrease(amount : int):
	hp = hp - amount
	var remain_hp = (hp/max_hp) * 100
	health_bar.value = remain_hp 
	health_num.text = String(hp)
	if hp == 3:
		health_bar.set_tint_progress(Color(1, 1, 0))
	elif hp == 2:
		health_bar.set_tint_progress(Color(1, 0.5, 0))
	elif hp == 1 :
		health_bar.set_tint_progress(Color(1, 0, 0))

func health_increase(amount: int):
	if hp < max_hp:
		hp += amount
		var remain_hp = (hp/max_hp) * 100
		health_bar.value = remain_hp 
		health_num.text = String(hp)
		if hp == 3:
			health_bar.set_tint_progress(Color(1, 1, 0))
		elif hp == 2:
			health_bar.set_tint_progress(Color(1, 0.5, 0))
		elif hp == 1:
			health_bar.set_tint_progress(Color(1, 0, 0))
		elif hp <= 4:
			health_bar.set_tint_progress(Color(0,1,0))

			

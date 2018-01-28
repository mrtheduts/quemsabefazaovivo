extends Node2D

var skin
func _ready():
	
	skin = find_node("termometro")
	set_fixed_process(true)

func _fixed_process(delta):
	
	skin.set_frame(int(global.termometro))
	global.termometro += 0.01
	if global.termometro < 0:
		global.termometro = 0
	if global.termometro > 9:
		global.termometro = 9
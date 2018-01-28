extends Node2D

var opacity = 0
onready var visual = get_node("Sprite")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	visual.set_opacity(opacity)
	visual.set_flip_h(true)
	
	if global.termometro >= 1 && global.termometro < 2:
		opacity -= 0.003
	elif global.termometro >= 3 && global.termometro < 5:
		opacity -= 0.0003
	elif global.termometro >= 5 && global.termometro < 6:
		opacity -= 0.00003
	elif global.termometro >= 6 && global.termometro <= 9:
		opacity += 0.0003
	if opacity > 1:
		opacity = 1
	if opacity < 0:
		opacity = 0
	
	pass
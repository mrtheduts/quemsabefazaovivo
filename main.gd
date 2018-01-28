extends Node2D

var tempo = 31
onready var timer = get_node("timer")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	tempo -= delta
	timer.set_text(String(int(tempo)))
	global.termometrofinal = global.termometro
	if tempo <= 0:
		get_parent().get_node("menuiniciar").retry(get_path())
		tempo = 0
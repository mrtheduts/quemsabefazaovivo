extends Node
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var termometro
var termometrofinal
func _ready():
	# Called every time the node is added to the scene.
	# Initialization
	termometro = 9
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	pass
extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	if global.termometrofinal <= 5:
		get_node("vocevenceu").show()
		get_node("SamplePlayer").play("ScreamOfJoy")
		get_node("SamplePlayer").play("ComoIssoAconteceu")
	else:
		get_node("gameover").show()
		get_node("SamplePlayer").play("Boo2")
		get_node("SamplePlayer").play("Eeeeita")
	# Initialization here
	pass


func _on_TextureButton_pressed():
	global.termometro = 9
	get_parent().get_node("menuiniciar")._on_jogar_pressed()
	get_parent().remove_child(get_node(get_path()))
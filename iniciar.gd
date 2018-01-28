extends Node2D

var maingame = preload("res://main.tscn")
var retryscreen = preload("res://gameover.tscn")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("SamplePlayer").play("TaPegandoFogoBicho")
	pass

func _on_jogar_pressed():
	var game = maingame.instance()
	get_parent().add_child(game)
	hide()
	pass # replace with function body
func retry(pathtochild):
	get_node("SamplePlayer").play("Buzzer")
	get_parent().remove_child(get_node(pathtochild))
	var retry = retryscreen.instance()
	get_parent().add_child(retry)
	pass
	
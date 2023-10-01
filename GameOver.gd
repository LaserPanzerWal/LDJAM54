extends Node2D

var textvisible = 0
var textspeed = 0.25

func _ready():
	GameController.game_finished()

func _process(delta):
	textvisible += delta * textspeed
	textvisible = clamp(textvisible, 0, 1)
	$ColorRect/Panel/Text.percent_visible = textvisible
	if(textvisible >= 1.0):
		$ColorRect/Panel/Continue.show()

func _input(event):
	if(textvisible >= 1.0):
		if event.is_action_pressed("input_a") || event.is_action_pressed("input_b") || event.is_action_pressed("input_start"):
			get_tree().change_scene("res://Menu.tscn")

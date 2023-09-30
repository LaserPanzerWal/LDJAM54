extends Control


onready var startbot = $MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/TextureRect
onready var startbot2 = $MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/TextureRect2
var selection = 0
var menuoptions = 2

func _ready():
	update_startbots()

func _input(event):
	if event.is_action_pressed("input_down") || event.is_action_pressed("input_select"):
		selection +=1
		if selection == menuoptions:
			selection = 0
		update_startbots()
	if event.is_action_pressed("input_up"):
		selection -= 1
		if selection < 0:
			selection = menuoptions -1
		update_startbots()
	if event.is_action_pressed("input_a") || event.is_action_pressed("input_b") || event.is_action_pressed("input_start"):
		item_select()

func update_startbots():
	match selection:
		0:
			startbot.modulate.a = 1
			startbot2.modulate.a = 0
		1:
			startbot.modulate.a = 0
			startbot2.modulate.a = 1

func item_select():
	match selection:
		0:
			get_tree().change_scene("res://map.tscn")
		1:
			pass

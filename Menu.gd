extends Control


onready var startbot = $MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/TextureRect
onready var startbot2 = $MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/TextureRect2
var selection = 0
var menuoptions = 2
var isactive = true

var waitframe = 0	#I dont want to talk about this BS, but at least it works and I'm out of time

func _ready():
	update_startbots()

func _process(delta):
	if waitframe > 0:
		waitframe -= 1

func _input(event):
	if(isactive && waitframe == 0):
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
			toggle_settings()

func toggle_settings():
	print("duh")
	if(isactive):
		isactive = false
		$Config.show()
	else:
		waitframe = 1
		isactive = true
		$Config.hide()
		

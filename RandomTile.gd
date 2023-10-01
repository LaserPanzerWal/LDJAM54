extends Node2D

func _ready():
	if(randi()%10 <=1):
		var kids = get_children()
		for kid in kids:
			kid.hide()
		kids[randi()%kids.size()].show()

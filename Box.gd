extends Sprite

var map
var speed = 96 setget ,get_speed
var positions = []

func _ready():
	map = get_parent()

func get_speed():
	return speed

func undo():
	print("eh")
	position = positions.pop_back()

func push(dir):
	positions.append(position)
	match dir:
		0:
			if(map.can_move_on(position + Vector2(map.tilesize,0))):
				position.x += map.tilesize
		1:
			if(map.can_move_on(position + Vector2(0,map.tilesize))):
				position.y += map.tilesize
		2:
			if(map.can_move_on(position - Vector2(map.tilesize,0))):
				position.x -= map.tilesize
		3:
			if(map.can_move_on(position - Vector2(0,map.tilesize))):
				position.y -= map.tilesize

extends Node2D
signal update_targets

var map = []
var tiles = []
var tilesize = 16
var memorylimit = 8 setget set_memory_limit, get_memory_limit
var targets = 0
var round_active = true

var robotscene = preload("res://Robot.tscn")
var floorscene = preload("res://Floor.tscn")
var wallscene = preload("res://Wall.tscn")
var terminalscene = preload("res://Terminal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_map()
	init_robot(8,7)
	self.connect("update_targets", get_parent(), "update_targets")

func _process(delta):
	update_targets()

func init_map():
	for i in range(16):
		map.append([])
		tiles.append([])
		for j in range (13):
			#map[i].append(randi()%2)
			map[i].append(0)
			tiles[i].append(null)
			if(i == 1 && j == 4):
				map[i][j] = 2
			if(i == 0 && j == 5):
				map[i][j] = 1
			init_tile(i,j)

func init_tile(x,y):
	#based on integer mapping:
	#0 = floor
	#1 = wall
	#2 = terminal
	var object
	if(map[x][y] == 0):
		object = floorscene.instance()
		tiles[x][y] = object
	if(map[x][y] == 1):
		object = wallscene.instance()
		tiles[x][y] = object
	if(map[x][y] == 2):
		object = terminalscene.instance()
		tiles[x][y] = object
		targets += 1
	add_child(object)
	object.position = Vector2(x*tilesize, y*tilesize)

func init_robot(x,y):
	var object = robotscene.instance()
	add_child(object)
	object.position = Vector2(x*tilesize,y*tilesize)
	object.connect("update_memory", get_parent(), "update_memory")

func is_floor(pos):
	var gridpos = get_grid_pos(pos)
	if(pos.x < 0 || gridpos.x >= (map.size())):
		check_terminal(gridpos)
		return false
	if(pos.y < 0 || gridpos.y >= (map[0].size())):
		check_terminal(gridpos)
		return false
	#check if tile is floor	
	if(map[gridpos.x][gridpos.y] == 0):
		return true
	else:
		check_terminal(gridpos)
		return false

func check_terminal(pos):
	var gridpos = get_grid_pos(pos)
	if(gridpos.x < map.size() -3 && map[gridpos.x+1][gridpos.y] == 2):
		targets -= 1
	if(gridpos.x > 0 && map[gridpos.x-1][gridpos.y] == 2):
		targets -= 1
	if(gridpos.y < map[0].size() -3 && map[gridpos.x][gridpos.y+1] == 2):
		targets -= 1
	if(gridpos.y > 0 && map[gridpos.x][gridpos.y-1] == 2):
		targets -= 1
	if(targets == 0):
		round_active = false
		print("You won!")

func get_grid_pos(pos):
	var x = int(pos.x) / 16
	var y = int(pos.y) / 16
	return Vector2(x,y)

func set_memory_limit(value):
	memorylimit = value

func get_memory_limit():
	return memorylimit

func update_targets():
	emit_signal("update_targets", targets)

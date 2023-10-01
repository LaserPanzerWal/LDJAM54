extends Node2D
signal update_targets

var map = []
var robot
var robotstart: Vector2
var tiles = []
var tilesize = 16
var memorylimit = 8 setget set_memory_limit, get_memory_limit
var targets = 0
var round_active = true

var level:int
var ended = false

var robotscene = preload("res://Robot.tscn")
var floorscene = preload("res://Floor.tscn")
var wallscene = preload("res://Wall.tscn")
var terminalscene = preload("res://Terminal.tscn")
var pushtileupscene = preload("res://Pushtile_Up.tscn")
var pushtiledownscene = preload("res://Pushtile_Down.tscn")
var pushtileleftscene = preload("res://Pushtile_Left.tscn")
var pushtilerightscene = preload("res://Pushtile_Right.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	level = GameController.get_next_level()
	init_map(level)
	self.connect("update_targets", get_parent(), "update_targets")

func _process(delta):
	update_targets()

func _input(event):
	if(ended):
		if event.is_action_pressed("input_a") || event.is_action_pressed("input_b") || event.is_action_pressed("input_start"):
			get_tree().change_scene("res://map.tscn")

func init_map(lvl):
	var levelget = Levels.get_level(lvl)
	if(levelget == null):
		print("no more levels")
		return
	var levelstring = levelget.split(";",false)
	var startpos = levelstring[0].split(",",false)
	init_robot(int(startpos[0]),int(startpos[1]))
	memorylimit = int(levelstring[1])
	for i in range(0,levelstring.size()-2):
		var line = levelstring[i+2].split(",",false)
		map.append([])
		tiles.append([])
		for j in range(0,line.size()):
			map[i].append(int(line[j]))
			tiles[i].append(null)
			init_tile(i,j)

#func init_map():
#	for i in range(16):
#		map.append([])
#		tiles.append([])
#		for j in range (13):
#			#map[i].append(randi()%2)
#			map[i].append(0)
#			tiles[i].append(null)
#			if(i == 1 && j == 4):
#				map[i][j] = 2
#			if(i == 0 && j == 5):
#				map[i][j] = 1
#			init_tile(i,j)

func init_tile(x,y):
	#based on integer mapping:
	#0 = floor
	#1 = wall
	#2 = terminal
	#3 = pushtile right
	#4 = pushtile down
	#5 = pushtile left
	#6 = pushtile up
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
	if(map[x][y] == 3):
		object = pushtilerightscene.instance()
		tiles[x][y] = object
	if(map[x][y] == 4):
		object = pushtiledownscene.instance()
		tiles[x][y] = object
	if(map[x][y] == 5):
		object = pushtileleftscene.instance()
		tiles[x][y] = object
	if(map[x][y] == 6):
		object = pushtileupscene.instance()
		tiles[x][y] = object
	add_child(object)
	object.position = Vector2(x*tilesize, y*tilesize)

func init_robot(x,y):
	robot = robotscene.instance()
	add_child(robot)
	robot.position = Vector2(x*tilesize + tilesize/2,y*tilesize + tilesize/2)
	robotstart = robot.position
	robot.connect("update_memory", get_parent(), "update_memory")
	robot.connect("path_finished", get_parent(), "end_level")
	robot.connect("path_finished", self, "end_level")

func can_move_on(pos):
	var gridpos = get_grid_pos(pos)
	#check if level border is hit
	if(pos.x < 0 || gridpos.x >= (map.size())):
		return false
	if(pos.y < 0 || gridpos.y >= (map[0].size())):
		return false
	#check if tile is floor
	var floortiles = [0,3,4,5,6]
	if(floortiles.has(map[gridpos.x][gridpos.y])):
		return true
	else:
		return false

func is_on_pushtile(pos):
	var gridpos = get_grid_pos(pos)
	var movetiles = [3,4,5,6]
	if movetiles.has(map[gridpos.x][gridpos.y]):
		return true
	else:
		return false

func get_push_dir(pos):
	var gridpos = get_grid_pos(pos)
	return tiles[gridpos.x][gridpos.y].get_push()

func check_terminal(pos):
	var result = []
	if(!round_active):
		return
	var gridpos = get_grid_pos(pos)
	if(gridpos.x < map.size() -3 && map[gridpos.x+1][gridpos.y] == 2):
		if !tiles[gridpos.x+1][gridpos.y].get_running():
			tiles[gridpos.x+1][gridpos.y].set_running(true)
			targets -= 1
			result.append(tiles[gridpos.x+1][gridpos.y])
	if(gridpos.x > 0 && map[gridpos.x-1][gridpos.y] == 2):
		if !tiles[gridpos.x-1][gridpos.y].get_running():
			tiles[gridpos.x-1][gridpos.y].set_running(true)
			targets -= 1
			result.append(tiles[gridpos.x-1][gridpos.y])
	if(gridpos.y < map[0].size() -3 && map[gridpos.x][gridpos.y+1] == 2):
		if !tiles[gridpos.x][gridpos.y+1].get_running():
			tiles[gridpos.x][gridpos.y+1].set_running(true)
			targets -= 1
			result.append(tiles[gridpos.x][gridpos.y+1])
	if(gridpos.y > 0 && map[gridpos.x][gridpos.y-1] == 2):
		if !tiles[gridpos.x][gridpos.y-1].get_running():
			tiles[gridpos.x][gridpos.y-1].set_running(true)
			targets -= 1
			result.append(tiles[gridpos.x][gridpos.y-1])
	if(targets == 0):
		round_active = false
		print("You won!")
		play_program()
	return result

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

func play_program():
	get_parent().switch_mode()
	robot.position = robotstart
	robot.play_program()

func end_level():
	if(!ended):
		GameController.level_finished(level)
		ended = true
	
func undoterminal():
	targets += 1

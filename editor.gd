extends Node2D

var map = []
var tiles = []
var start = Vector2.ZERO
var starttile
var tilesize = 16
var currenttile = 0

var startscene = preload("res://Start.tscn")
var floorscene = preload("res://Floor.tscn")
var wallscene = preload("res://Wall.tscn")
var terminalscene = preload("res://Terminal.tscn")

var tilelabel
var resultbox

func _ready():
	init_map()
	tilelabel = $tile
	tilelabel.text = String(currenttile)
	resultbox = $TextEdit
	starttile = startscene.instance()
	add_child(starttile)
	starttile.position = start

func init_map():
	for i in range(16):
		map.append([])
		tiles.append([])
		for j in range (13):
			#map[i].append(randi()%2)
			map[i].append(0)
			tiles[i].append(null)
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
	add_child(object)
	object.position = Vector2(x*tilesize, y*tilesize)

func _input(event):
	if event is InputEventMouseButton:
		if(event.button_index == 1 && event.pressed):
			var gridpos = get_grid_pos(event.position)
			if(gridpos.x >= 0 && gridpos.x < map.size()):
				if(gridpos.y >=0 && gridpos.y < map[0].size()):
					if(currenttile == 9):
						start = gridpos
						starttile.position = gridpos * tilesize
					else:
						map[gridpos.x][gridpos.y] = currenttile
						tiles[gridpos.x][gridpos.y].queue_free()
						if(map[gridpos.x][gridpos.y] == 0):
							tiles[gridpos.x][gridpos.y] = floorscene.instance()
						if(map[gridpos.x][gridpos.y] == 1):
							tiles[gridpos.x][gridpos.y] = wallscene.instance()
						if(map[gridpos.x][gridpos.y] == 2):
							tiles[gridpos.x][gridpos.y] = terminalscene.instance()
						add_child(tiles[gridpos.x][gridpos.y])
						tiles[gridpos.x][gridpos.y].position = Vector2(gridpos.x*tilesize, gridpos.y*tilesize)
					update_string()
		
	if event is InputEventKey:
		if(event.pressed && !event.echo):
			if(event.scancode >= 48 && event.scancode <= 57):
				currenttile = int(OS.get_scancode_string(event.scancode))
				tilelabel.text = String(currenttile)

func get_grid_pos(pos):
	var x = int(pos.x) / 16
	var y = int(pos.y) / 16
	return Vector2(x,y)

func update_string():
	var res = str(start.x) + "," + str(start.y) + ";"	
	for line in map:
		for tile in line:
			res += str(tile) + ","
		res.erase(res.length()-1,1)
		res += ";"
	resultbox.text = res

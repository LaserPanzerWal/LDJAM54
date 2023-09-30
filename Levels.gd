extends Node

var levels = ["7,7;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,1,1,1,1,1,1,1,0,0,0,0;0,0,1,0,0,0,0,0,1,0,0,0,0;0,0,1,0,1,1,1,1,1,0,0,0,0;0,0,1,0,1,0,0,0,0,0,0,0,0;0,0,1,2,1,0,0,0,0,0,0,0,0;0,0,1,1,1,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;",
	"3,6;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,1,1,1,1,1,0,0,0,0,0;0,0,0,1,0,0,0,1,0,0,0,0,0;0,0,0,1,0,1,1,1,0,0,0,0,0;0,0,0,1,0,0,2,1,0,0,0,0,0;0,0,0,1,0,0,0,1,0,0,0,0,0;0,0,0,1,0,0,0,1,0,0,0,0,0;0,0,0,1,1,1,0,1,0,0,0,0,0;0,0,0,1,2,1,0,1,0,0,0,0,0;0,0,0,1,0,1,0,1,0,0,0,0,0;0,0,0,1,0,0,0,1,0,0,0,0,0;0,0,0,1,0,0,0,1,0,0,0,0,0;0,0,0,1,1,1,1,1,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0;"
	]

func get_level(i):
	if(i >=0 && i < levels.size()):
		return levels[i]
	else:
		return null
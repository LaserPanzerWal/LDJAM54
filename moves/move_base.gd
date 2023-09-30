class_name move_base
var startpos:Vector2

func perform(obj,delta):
	if(!startpos):
		startpos = obj.position

func undo(obj):
	obj.position = startpos
	obj.position = obj.get_map().get_grid_pos(obj.position) * obj.get_map().tilesize

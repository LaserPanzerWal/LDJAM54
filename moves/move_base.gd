class_name move_base
var startpos:Vector2
var undoterminals = []
var undobox = null

func perform(obj,delta):
	if(!startpos):
		startpos = obj.position

func undo(obj):
	obj.position = (obj.get_map().get_grid_pos(startpos) * obj.get_map().tilesize) + Vector2(obj.get_map().tilesize / 2, obj.get_map().tilesize /2)
	for term in undoterminals:
		term.set_running(false)
		obj.get_map().undoterminal()
	if(undobox):
		undobox.undo()

class_name move_base
var startpos:Vector2
var undoterminals = []
var undoboxes = []

func perform(obj,delta):
	if(!startpos):
		startpos = obj.position

func undo(obj):
	obj.position = (obj.get_map().get_grid_pos(startpos) * obj.get_map().tilesize) + Vector2(obj.get_map().tilesize / 2, obj.get_map().tilesize /2)
	for term in undoterminals:
		term.set_running(false)
		obj.get_map().undoterminal()
	for box in undoboxes:
		box.undo()

func add_box(obj, box):
	if(box):
		if(obj.moves.back() == self):
			undoboxes.append(box)
		else:
			if(obj.moves.back()):
				obj.moves.back().add_box(obj, box)

func get_boxes():
	return undoboxes

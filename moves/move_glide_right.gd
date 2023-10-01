class_name move_glide_right
extends move_base

func perform(obj,delta):
	.perform(obj,delta)
	var nextPos = Vector2(obj.position.x + obj.get_speed() * delta,obj.position.y)
	if obj.get_map().is_floor(nextPos + Vector2(16,0)):
		obj.position = nextPos
		return false
	else:
		obj.position = obj.get_map().get_grid_pos(obj.position + Vector2(15,0)) * obj.get_map().tilesize
		undoterminals = obj.get_map().check_terminal(obj.position)
		return true

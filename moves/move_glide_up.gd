class_name move_glide_up
extends move_base

func perform(obj,delta):
	.perform(obj,delta)
	var nextPos = Vector2(obj.position.x,obj.position.y - obj.get_speed() * delta)
	if obj.get_map().is_floor(nextPos):
		obj.position = nextPos
		return false
	else:
		obj.position = obj.get_map().get_grid_pos(obj.position) * obj.get_map().tilesize
		obj.get_map().check_terminal(obj.position)
		return true

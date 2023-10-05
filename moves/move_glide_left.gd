class_name move_glide_left
extends move_base

func perform(obj,delta):
	.perform(obj,delta)
	obj.set_direction(2)
	var nextPos = Vector2(obj.position.x - obj.get_speed() * delta,obj.position.y)
	if obj.get_map().is_on_pushtile(nextPos + Vector2(7,0)):
		obj.apply_push(obj.get_map().get_push_dir(nextPos + Vector2(7,0)))
	
	if obj.get_map().can_move_on(nextPos + Vector2 (-7,0)):
		obj.position = nextPos
		return false
	else:
		add_box(obj, obj.get_map().try_push_box(nextPos + Vector2 (-7,0), 2))
		obj.position = (obj.get_map().get_grid_pos(obj.position + Vector2 (-7,0)) * obj.get_map().tilesize) + Vector2(obj.get_map().tilesize / 2, obj.get_map().tilesize /2)
		undoterminals = obj.get_map().check_terminal(obj.position)
		return true

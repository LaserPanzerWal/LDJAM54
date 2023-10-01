extends Sprite


func get_box():
	var box = $Box
	remove_child(box)
	return box

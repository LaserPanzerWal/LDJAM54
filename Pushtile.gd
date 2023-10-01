extends Node2D

export var direction = 0

#0 = right
#1 = down
#2 = left
#3 = up

func get_push():
	play_sound()
	match direction:
		0:
			return move_glide_right.new()
		1:
			return move_glide_down.new()
		2:
			return move_glide_left.new()
		3:
			return move_glide_up.new()

func play_sound():
	if !$Audio.is_playing():
		$Audio.play()

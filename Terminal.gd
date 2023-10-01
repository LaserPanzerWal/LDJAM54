extends Sprite

var running = false setget set_running, get_running

func set_running(val):
	running = val
	if(val):
		$AudioStreamPlayer.play()

func get_running():
	return running

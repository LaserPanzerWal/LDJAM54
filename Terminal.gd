extends Node

var running = false setget set_running, get_running

func set_running(val):
	running = val
	if(val):
		$AudioStreamPlayer.play()
		$Terminal.hide()
		$TerminalAnimated.show()
	else:
		$Terminal.show()
		$TerminalAnimated.hide()

func get_running():
	return running

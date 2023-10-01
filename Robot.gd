extends Sprite
signal update_memory
signal path_finished

var interactive = true
var speed = 96 setget ,get_speed
var moves = []
var currentMove = null
var map setget , get_map


var impactsound:AudioStream = preload("res://sounds/wallimpact.wav")
onready var audio = $AudioStreamPlayer


func _ready():
	map = get_parent()

func _process(delta):
	update_memcount()
	if interactive:
		if(map.round_active):
			if(!currentMove):
				if(Input.is_action_just_pressed("input_a")):
					if(moves.size() > 0):
						var move = moves.pop_back()
						move.undo(self)
						return
				if(Input.is_action_just_pressed("input_up")):
					if(has_memory_left()):
						var obj = move_glide_up.new()
						moves.append(obj)
						currentMove = obj
						return
				if(Input.is_action_just_pressed("input_down")):
					if(has_memory_left()):
						var obj = move_glide_down.new()
						moves.append(obj)
						currentMove = obj
						return
				if(Input.is_action_just_pressed("input_right")):
					if(has_memory_left()):
						var obj = move_glide_right.new()
						moves.append(obj)
						currentMove = obj
						return
				if(Input.is_action_just_pressed("input_left")):
					if(has_memory_left()):
						var obj = move_glide_left.new()
						moves.append(obj)
						currentMove = obj
						return
			else:
				var finished = currentMove.perform(self,delta)
				if(finished):
					currentMove = null
					audio.stream = impactsound
					audio.play()
	else:
		if(!currentMove && moves.size() > 0):
			currentMove = moves.pop_front()
		if(currentMove):
			var finished = currentMove.perform(self,delta)
			if(finished):
				currentMove = null
				audio.stream = impactsound
				audio.play()
		else:
			emit_signal("path_finished")

func play_program():
	currentMove = null
	interactive = false

func has_memory_left():
	if(moves.size() >= map.get_memory_limit()):
		#play sound
		return false
	else:
		return true

func get_speed():
	return speed

func get_map():
	return map

func update_memcount():
	if(interactive):
		emit_signal("update_memory", map.get_memory_limit() - moves.size())

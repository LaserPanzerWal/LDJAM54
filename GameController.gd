extends Node

var musicVol = 1.0 setget set_music_vol,get_music_vol
var soundVol = 1.0 setget set_sound_vol,get_sound_vol
var unlockedLevel = 0 setget ,get_unlocked_level
var nextLevel = 0 setget ,get_next_level

func set_music_vol(value):
	value = clamp(value, 0, 1.0)
	musicVol = value
	print(musicVol)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(musicVol))

func get_music_vol():
	return musicVol

func set_sound_vol(value):
	value = clamp(value, 0,1.0)
	soundVol = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Audio"), linear2db(soundVol))

func get_sound_vol():
	return soundVol

func get_unlocked_level():
	return unlockedLevel

func get_next_level():
	return nextLevel

func level_finished(level):
	nextLevel += 1
	if nextLevel > unlockedLevel:
		unlockedLevel = nextLevel

func game_finished():
	nextLevel = 0

extends Node

var musicVol = 1.0 setget set_music_vol,get_music_vol
var soundVol = 1.0 setget set_sound_vol,get_sound_vol
var unlockedLevel = 0 setget ,get_unlocked_level
var nextLevel = 0 setget ,get_next_level

func set_music_vol(value):
	value = clamp(value, 0, 1.0)
	musicVol = value

func get_music_vol():
	return musicVol

func set_sound_vol(value):
	value = clamp(value, 0, 1.0)
	soundVol = value

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

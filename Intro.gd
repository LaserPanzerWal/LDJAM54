extends Node2D

func _ready():
	$LdJamLogo/AnimationPlayer.play("Intro")

func continue():
	get_tree().change_scene("res://Menu.tscn")

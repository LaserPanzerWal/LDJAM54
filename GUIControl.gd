extends Node2D

onready var memfree = $Control/TopBar/MemFree_Value
onready var targets = $Control/TopBar/TargetsLeft_Value
onready var mode = $Control/TopBar/Mode_Title

func _ready():
	pass

func update_memory(value):
	memfree.text = String(value)

func update_targets(value):
	targets.text = String(value)

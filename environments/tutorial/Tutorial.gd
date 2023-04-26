extends Node2D

signal enter_area_1
signal enter_area_2
signal enter_area_3

onready var player = $Player
onready var portal = $portal


# Called when the node enters the scene tree for the first time.
func _ready():
	portal.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Mob_mob_killed():
	portal.show()

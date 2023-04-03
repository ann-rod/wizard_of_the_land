extends Control

signal returned_to_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_ReturnToGame_pressed():
	emit_signal("returned_to_game")


func _on_ReturnToTitle_pressed():
	get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")

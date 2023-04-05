extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_MenuButton_pressed():
	get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")
	
func _on_Level1Button_pressed():
	get_tree().change_scene("res://environments/level1/level1.tscn")

func _on_Level2Button_pressed():
	get_tree().change_scene("res://environments/level2/level2.tscn")

func _on_Level3Button_pressed():
	get_tree().change_scene("res://environments/level3/level3.tscn")

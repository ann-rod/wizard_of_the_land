extends Node2D

onready var player = $Player
onready var menu_button = $menubutton
onready var level1_button = $level1button
onready var level2_button = $level2button
onready var portallabel = $Control/portallabel
onready var textbox = $Control/ColorRect




func _ready():
	_on_portal_area_exited(player.get_node("Area2D"))

func _on_portal_area_entered(area):
	if area == player.get_node("Area2D"):
		portallabel.show()
		textbox.show()
		
		buttons_enable()

func _on_portal_area_exited(area):
	if area == player.get_node("Area2D"):
		portallabel.hide()
		textbox.hide()
		
		buttons_disable()

func _on_menubutton_pressed():
	get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")

func _on_level1button_pressed():
	get_tree().change_scene("res://environments/level1/level1.tscn")

func _on_level2button_pressed():
	get_tree().change_scene("res://environments/level2/level2.tscn")

func buttons_disable():
	menu_button.disabled = true
	level1_button.disabled = true
	level2_button.disabled = true
	menu_button.hide()
	level1_button.hide()
	level2_button.hide()
	
func buttons_enable():
	menu_button.disabled = false
	level1_button.disabled = false
	level2_button.disabled = false
	menu_button.show()
	level1_button.show()
	level2_button.show()

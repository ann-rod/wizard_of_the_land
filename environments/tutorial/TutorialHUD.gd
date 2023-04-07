extends Control

onready var instructions_next = $MessageBackground/InstructionsNext
onready var instructions_back = $MessageBackground/InstructionsBack
onready var menu_button = $MenuButton
onready var message_background = $MessageBackground
onready var page_label = $MessageBackground/PageLabel
onready var instructions_label = $MessageBackground/InstructionLabel

var instructions = ['Use WASD to move around', 'Aim with MOUSE and press LEFT CLICK to shoot', 'Avoid or shoot enemies to stay alive']

var page_number = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	instructions_back.hide()
	page_label.text = str(page_number) + " / 3"
	instructions_label.text = instructions[page_number - 1]

func _on_MenuButton_pressed():
	get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")

func _on_InstructionsNext_pressed():
	if page_number < 4:
		page_number += 1
		page_label.text = str(page_number) + " / 3"
		instructions_label.text = instructions[page_number - 1]
		check_page_number()
	

func _on_InstructionsBack_pressed():
	if page_number > 1:
		page_number -= 1
		page_label.text = str(page_number) + " / 3"
		instructions_label.text = instructions[page_number - 1]
		check_page_number()
	
		
func check_page_number():
	if (page_number in [1, 2]):
		instructions_next.show()
	else:
		instructions_next.hide()
	if (page_number in [2, 3]):
		instructions_back.show()
	else:
		instructions_back.hide()

func _on_Area2D_area_entered(area):
	#if area.name == "PlayerArea2D":
		#message_background.modulate = Color(255, 255, 255, 50)
	pass

func _on_Area2D_area_exited(area):
	pass # Replace with function body.

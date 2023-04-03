extends Control

signal start_tutorial
signal game_is_paused

var is_paused = false

onready var pause_menu = $PauseMenu
onready var pause_button = $PauseButton

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseBG.hide()
	pause_menu.hide()
	pause_button.pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	pass

func _on_PauseButton_toggled(button_pressed):
	if button_pressed:
		print('paused')
		$PauseBG.show()
		pause_menu.show()
		is_paused = true
	else:
		print('unpaused')
		pause_menu.hide()
		$PauseBG.hide()
		is_paused = false

	get_tree().paused = is_paused


func _on_PauseMenu_returned_to_game():
	pause_menu.hide()
	$PauseBG.hide()
	
	is_paused = false
	get_tree().paused = is_paused

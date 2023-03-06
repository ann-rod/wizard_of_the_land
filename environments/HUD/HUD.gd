extends Control

signal start_tutorial
signal game_is_paused

var instruction_labels = ['Use WASD to move around', 'LEFT CLICK to shoot', 'Avoid enemies to stay alive']
var instruction_page = 0
var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseBG.hide()
		
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		_on_PauseButton_pressed()

func _on_PauseButton_pressed():
	if is_paused == false:
		$PauseBG.show()
		is_paused = true
	else:
		is_paused = false
		$PauseBG.hide()

func _on_PauseBG_mouse_entered():
	emit_signal("game_is_paused")

func _on_PauseBG_mouse_exited():
	emit_signal("game_is_paused")

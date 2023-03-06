extends Control

signal disable_spells
signal enable_spells
signal start_tutorial

var instruction_labels = ['Use WASD to move around', 'LEFT CLICK to shoot', 'Avoid enemies to stay alive']
var instruction_page = 0
var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseBG.hide()
	$TutorialButton.hide()
	$TutorialLabel.hide()
	$Instructions.hide()
		
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		_on_PauseButton_pressed()

func _on_PauseButton_pressed():
	if is_paused == false:
		$PauseBG.show()
		$TutorialButton.show()
		is_paused = true
	else:
		is_paused = false
		$TutorialButton.hide()
		$PauseBG.hide()

func _on_TutorialButton_pressed():
	$PauseBG.hide()
	$TutorialButton.hide()
	$TutorialLabel.show()
	
	$Instructions.show()
	$Instructions.text = instruction_labels[instruction_page]
	emit_signal("start_tutorial")

func _on_NextButton_pressed():
	if instruction_page < 2:
		if instruction_page == 1:
			$Instructions/NextButton.text = "Finish"
		instruction_page += 1
		$Instructions.text = instruction_labels[instruction_page]
		
	else:
		$Instructions.hide()
		$TutorialLabel.hide()
		is_paused = false
		instruction_page = 0
		$Instructions/NextButton.text = "Next"

func _on_PauseBG_mouse_entered():
	emit_signal("disable_spells")

func _on_PauseBG_mouse_exited():
	emit_signal("enable_spells")

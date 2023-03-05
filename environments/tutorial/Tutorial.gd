extends Node2D

signal enter_area_1
signal enter_area_2
signal enter_area_3

onready var instruction_label = $TutorialHUD/InstructionsLabel

var instructions = ['Use WASD to move around', 'Aim with MOUSE and press LEFT CLICK to shoot', 'Avoid enemies to stay alive']


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FirstArea_area_entered(area):
	if area.name == "Player":
		instruction_label.text = instructions[0]
		$SecondArea.monitoring = true
		$FirstArea.monitoring = true
		print('Entered 1st area!')
		emit_signal('enter_area_1')


func _on_FirstArea_area_exited(area):
	print('Left 1st area!')


func _on_SecondArea_area_entered(area):
	if area.name == "Player":
		instruction_label.text = instructions[1]
		print('Entered 2nd area')
		emit_signal('enter_area_2')


func _on_SecondArea_area_exited(area):
	print('Left 2nd area')


func _on_ThirdArea_area_entered(area):
	if area.name == "Player":
		instruction_label.text = instructions[2]
		$SecondArea.monitoring = false
		$FirstArea.monitoring = false
		print('Entered 3rd area!')
		emit_signal('enter_area_3')


func _on_ThirdArea_area_exited(area):
	print('Left 3rd area')

extends Node2D

signal enter_area_1
signal enter_area_2
signal enter_area_3

onready var instruction_label = $TutorialHUD/InstructionsLabel
onready var tutorial_label = $TutorialHUD/TutorialLabel
onready var player = $Player
onready var chest = $Chest
onready var next_button = $NextButton

var instructions = ['Use WASD to move around', 'Aim with MOUSE and press LEFT CLICK to shoot', 'Avoid enemies to stay alive']

# Called when the node enters the scene tree for the first time.
func _ready():
	chest.hide()
	next_button.hide()
	next_button.disabled = true
	$Chest/Area2D/CollisionShape2D.set_deferred("disabled", true)


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


func _on_Mob_mob_killed():
	instruction_label.text = "Collect the chest to complete the level!"
	chest.show()
	$SecondArea.monitoring = false
	$FirstArea.monitoring = false
	$ThirdArea.monitoring = false
	$Chest/Area2D/CollisionShape2D.set_deferred("disabled", false)
	

func _on_Chest_chest_opened():
	print('chest collected')
	chest.hide()
	tutorial_label.text = "Congratulations!"
	instruction_label.text = "You have completed the tutorial!"
	next_button.show()
	next_button.disabled = false


func _on_NextButton_pressed():
	pass

func is_mouse_over_hud():
	var next_button_rect = next_button.get_global_rect()
	var mouse_pos = get_global_mouse_position()
	return next_button_rect.has_point(mouse_pos)

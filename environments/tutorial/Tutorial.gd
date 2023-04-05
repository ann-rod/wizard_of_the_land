extends Node2D

signal enter_area_1
signal enter_area_2
signal enter_area_3

onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FirstArea_area_entered(area):
	if area.name == "PlayerArea2D":
		
		$SecondArea.monitoring = true
		$FirstArea.monitoring = true
		print('Entered 1st area!')
		emit_signal('enter_area_1')


func _on_FirstArea_area_exited(area):
	print('Left 1st area!')


func _on_SecondArea_area_entered(area):
	if area.name == "PlayerArea2D":
		print('Entered 2nd area')
		emit_signal('enter_area_2')


func _on_SecondArea_area_exited(area):
	print('Left 2nd area')


func _on_ThirdArea_area_entered(area):
	if area.name == "PlayerArea2D":
		$SecondArea.monitoring = false
		$FirstArea.monitoring = false
		print('Entered 3rd area!')
		emit_signal('enter_area_3')


func _on_ThirdArea_area_exited(area):
	print('Left 3rd area')


func _on_Mob_mob_killed():
	$SecondArea.monitoring = false
	$FirstArea.monitoring = false
	$ThirdArea.monitoring = false

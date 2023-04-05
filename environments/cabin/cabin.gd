extends Node2D

onready var player = $Player
onready var cabin_hud = $CanvasLayer/CabinHUD

var wins = [true, false, false]

func _ready():
	_on_portal_area_exited(player.get_node("PlayerArea2D"))
	cabin_hud.hide()
	player.health_bar.visible = false

func _on_portal_area_entered(area):
	if area == player.get_node("PlayerArea2D"):
		cabin_hud.show()

func _on_portal_area_exited(area):
	if area == player.get_node("PlayerArea2D"):
		cabin_hud.hide()

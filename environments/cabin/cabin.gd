extends Node2D

onready var player = $Player
onready var cabin_hud = $CanvasLayer/CabinHUD
onready var gameObj = $CanvasLayer/gameobjective

onready var beatLevels = get_node("/root/Global")

func _ready():
	cabin_hud.hide()
	if beatLevels.level2ready == false:
		cabin_hud.get_node("Level2Button").hide()
	if beatLevels.level3ready == false:
		cabin_hud.get_node("Level3Button").hide()
	gameObj.hide()
	player.health_bar.visible = false

func _on_portal_area_entered(area):
	if area == player.get_node("PlayerArea2D"):
		cabin_hud.show()

func _on_portal_area_exited(area):
	if area == player.get_node("PlayerArea2D"):
		cabin_hud.hide()


func _on_cabinarea_area_entered(area):
	if area == player.get_node("PlayerArea2D"):
		gameObj.show()

func _on_cabinarea_area_exited(area):
	if area == player.get_node("PlayerArea2D"):
		gameObj.hide()

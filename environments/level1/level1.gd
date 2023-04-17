extends Node2D

signal player_reached_portal

onready var spell_manager = $SpellManager
onready var player = $Player
onready var map = $Map
onready var mob = $Mob
onready var level_1_hud = $CanvasLayer/Level1HUD

onready var beatLevels = get_node("/root/Global")


func _ready():
	player.connect("player_cast_spell", spell_manager, "handle_spell_spawned")
	level_1_hud.hide()
	
	#_on_portal_area_exited(player.get_node("PlayerArea2D"))

func game_over():
	print("game over!")
	player.hide() # hide player
	player.collision_shape.set_deferred("disabled", true) # disable collisions
	player.disconnect("player_cast_spell", spell_manager, "handle_spell_spawned")
	get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")
	
func _on_Player_player_hp_zero():
	game_over()


func _on_portal_area_entered(area):
	if area == player.get_node("PlayerArea2D"):
		print('emitting signal')
		emit_signal("player_reached_portal")
		level_1_hud.show()
		beatLevels.level2ready = true;


#func _on_portal_area_exited(area):
#	if area == player.get_node("PlayerArea2D"):
#		portallabel.hide()
#		textbox.hide()
#		menu_button.hide()
#		menu_button.disabled = true

extends Node2D

onready var spell_manager = $SpellManager
onready var player = $Player
onready var map = $Map
onready var mob = $Mob
onready var level_2_hud = $CanvasLayer/Level2HUD

onready var beatLevels = get_node("/root/Global")

func _ready():
	$levelMusic.play()
	player.connect("player_cast_spell", spell_manager, "handle_spell_spawned")
	level_2_hud.hide()

func game_over():
	print("game over!")
	player.hide() # hide player
	player.collision_shape.set_deferred("disabled", true) # disable collisions
	player.disconnect("player_cast_spell", spell_manager, "handle_spell_spawned")
	get_tree().change_scene("res://key_scenes/death/DeathScene.tscn")
	#get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")
	
func _on_Player_player_hp_zero():
	game_over()


func _on_portal_area_entered(area):
	if area == player.get_node("PlayerArea2D"):
		print('emitting signal')
		emit_signal("player_reached_portal")
		level_2_hud.show()
		
		beatLevels.level3ready = true;

	
	


#func _on_portal_area_exited(area):
#	if area == player.get_node("PlayerArea2D"):

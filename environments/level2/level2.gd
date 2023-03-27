extends Node2D

onready var spell_manager = $SpellManager
onready var player = $Player
onready var map = $Map
onready var mob = $Mob
onready var menu_button = $menubutton
onready var portallabel = $Control/portallabel
onready var textbox = $Control/ColorRect


func _ready():
	player.connect("player_cast_spell", spell_manager, "handle_spell_spawned")
	
	_on_portal_area_exited(player.get_node("Area2D"))

func game_over():
	print("game over!")
	player.hide() # hide player
	player.collision_shape.set_deferred("disabled", true) # disable collisions
	player.disconnect("player_cast_spell", spell_manager, "handle_spell_spawned")
	get_tree().change_scene("res://key_scenes/title_screen/TitleScreen.tscn")
	
func _on_Player_player_hp_zero():
	game_over()


func _on_portal_area_entered(area):
	if area == player.get_node("Area2D"):
		portallabel.show()
		textbox.show()
		menu_button.show()
		menu_button.disabled = false

func _on_menubutton_pressed():
	get_tree().change_scene("res://environments/cabin/cabin.tscn")
	
	


func _on_portal_area_exited(area):
	if area == player.get_node("Area2D"):
		portallabel.hide()
		textbox.hide()
		menu_button.hide()
		menu_button.disabled = true

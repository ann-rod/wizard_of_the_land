extends Node2D

onready var spell_manager = $SpellManager
onready var player = $Player
onready var map = $Map
onready var mob = $Mob


func _ready():
	player.connect("player_cast_spell", spell_manager, "handle_spell_spawned")

func game_over():
	print("game over!")
	player.hide() # hide player
	player.collision_shape.set_deferred("disabled", true) # disable collisions
	player.disconnect("player_cast_spell", spell_manager, "handle_spell_spawned")
	
func _on_Player_player_hp_zero():
	game_over()

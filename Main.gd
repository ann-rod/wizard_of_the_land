extends Node2D

onready var spell_manager = $SpellManager
onready var player = $Player
#onready var map = $Map
onready var mob = $Mob


func _ready():
	player.connect("player_cast_spell", spell_manager, "handle_spell_spawned")
	$OverworldTheme.play()
	

func game_over():
	$OverworldTheme.stop()

#func new_game():
#	#$Player.start($PlayerStartPosition.position)
#	$OverworldTheme.play()
	

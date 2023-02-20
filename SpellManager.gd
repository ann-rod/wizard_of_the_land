extends Node2D

func handle_spell_spawned(spell, pos, dir):
	add_child(spell)
	spell.global_position = pos
	spell.set_direction(dir)
	$SpellSound.play()

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

#func _process(delta):
#	pass

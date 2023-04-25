extends Node2D
var MOB_SPELL_SPEED = 2.5
var PLAYER_SPELL_SPEED = 3.5
var speed = PLAYER_SPELL_SPEED

func handle_spell_spawned(spell, spellcaster, spell_origin, dir):
	#print('spell!')
	print(spellcaster.name)
	add_child(spell)
	#if spellcaster.name == "Player":
		#spell.CollisionShape2D
	spell.global_position = spell_origin
	spell.init_spell(spellcaster, dir, speed)
	$SpellSound.play()

func _on_Mob_mob_cast_spell(spell, spellcaster, spell_origin, dir):
	speed = MOB_SPELL_SPEED # janky quick fix of mob/player speed variations
	self.handle_spell_spawned(spell, spellcaster, spell_origin, dir)
	speed = PLAYER_SPELL_SPEED

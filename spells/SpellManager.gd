extends Node2D

func handle_spell_spawned(spell, spellcaster, spell_origin, dir):
	#print('spell!')
	add_child(spell)
	spell.global_position = spell_origin
	spell.init_spell(spellcaster, dir)
	$SpellSound.play()

func _on_Mob_mob_cast_spell(spell, spellcaster, spell_origin, dir):
	self.handle_spell_spawned(spell, spellcaster, spell_origin, dir)

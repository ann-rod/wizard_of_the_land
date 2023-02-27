extends Area2D
#onready var player = $Player
onready var ai = $AI
onready var attack_cooldown = $MobAttackCooldown

export (PackedScene) var Spell

signal mob_killed
signal mob_cast_spell(spell, pos, dir)

var MOB_HP = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func handle_hit():
	MOB_HP -= 1
	print("mob hp: ", MOB_HP)
	
	# mob dies
	if(MOB_HP <= 0):
		print("mob killed!")
		queue_free()
		emit_signal("mob_killed")
		

func _on_AI_attempt_to_shoot(target):
	if(attack_cooldown.is_stopped()):
		var spell_instance = preload("res://spells/Spell.tscn").instance()
		var spell_origin = self.global_position
		var spell_dir = (target-spell_origin).normalized()
		emit_signal("mob_cast_spell", spell_instance, self, spell_origin, spell_dir)
		attack_cooldown.start()

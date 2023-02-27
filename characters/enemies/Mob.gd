extends Area2D

signal mob_killed
signal mob_cast_spell(spell, pos, dir)

export (PackedScene) var Spell

onready var ai = $AI
onready var attack_cooldown = $MobAttackCooldown
onready var collision_shape = $CollisionShape2D

var MOB_HP = 3
var MOB_SPEED = 150
var mob_direction = Vector2.ZERO
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	collision_shape.disabled = false # enable collisions

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = mob_direction.normalized()*MOB_SPEED
	
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "side"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y < 0:
		$AnimatedSprite.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "down"

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

func _on_AI_chase_target(target_pos):
	set_mob_direction(target_pos)

func set_mob_direction(target_pos):
	if(target_pos == Vector2.ZERO):
		target_pos = self.global_position
	mob_direction = target_pos - self.global_position

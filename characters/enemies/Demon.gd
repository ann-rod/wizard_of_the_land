extends KinematicBody2D

signal demon_killed
signal mob_cast_spell(spell, pos, dir)
signal under_attack(player_area)

export (PackedScene) var Spell

onready var ai = $AI
onready var health_bar = $HealthBar
onready var attack_cooldown = $DemonAttackCooldown
onready var collision_shape = $CollisionShape2D
onready var player

var MAX_HEALTH = 6
var CURRENT_HEALTH = 6

var MOB_SPEED = 30
var mob_direction = Vector2.ZERO
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	collision_shape.disabled = false # enable collisions
	init_health_bar()
	get_player()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = mob_direction.normalized()*MOB_SPEED
	
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	#position += velocity * delta
	move_and_slide(velocity)
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
	
func init_health_bar():
	health_bar._on_max_health_updated(MAX_HEALTH)
	health_bar._on_health_updated(MAX_HEALTH)

func get_player():
	if(has_node("../Player")):
		player = get_node("../Player")
	
func handle_hit():
	CURRENT_HEALTH -= 1
	health_bar._on_health_updated(CURRENT_HEALTH)
	emit_signal("under_attack", player) # received by AI script
	#print("mob hp: ", MOB_HP)
	
	# mob dies
	if(CURRENT_HEALTH <= 0):
		#print("mob killed!")
		queue_free()
		emit_signal("demon_killed")

func _on_AI_attempt_to_shoot(target):
	if(attack_cooldown.is_stopped()):
		var spell_instance = preload("res://spells/Spell.tscn").instance()
		spell_instance.modulate = Color(0,0,0.25) # change spell to appear blue
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


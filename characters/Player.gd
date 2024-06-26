extends KinematicBody2D

signal hit
signal player_hp_zero
signal player_cast_spell(spell, pos, dir)

var MAX_HEALTH = 7
var CURRENT_HEALTH = 7
export var speed = 150
var screen_size
var player_dir = Vector2(0, -1) # player dir defaults to up

export (PackedScene) var Spell
onready var health_bar = $HealthBar
onready var collision_shape = $PlayerArea2D/CollisionShape2D2
onready var attack_cooldown = $AttackCooldown
onready var spell_origin_up = $SpellOriginUp
onready var spell_origin_down = $SpellOriginDown
onready var spell_origin_right = $SpellOriginRight
onready var spell_origin_left = $SpellOriginLeft

func _ready():
	screen_size = get_viewport_rect().size
	collision_shape.disabled = false # enable collisions
	init_health_bar()

func _process(delta):
	var velocity = Vector2.ZERO 

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		player_dir = Vector2.ZERO
		player_dir.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		player_dir = Vector2.ZERO
		player_dir.x = -1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		player_dir = Vector2.ZERO
		player_dir.y = 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		player_dir = Vector2.ZERO
		player_dir.y = -1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
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

func _on_Player_body_entered(_body):
	emit_signal("hit")
	print("player was hit!")
	handle_hit()
	
func _physics_process(delta):
	pass
	

func handle_hit():
	CURRENT_HEALTH -= 1
	health_bar._on_health_updated(CURRENT_HEALTH)
	#print("current player HP:", CURRENT_HEALTH)
	
	if(CURRENT_HEALTH <= 0):
		emit_signal("player_hp_zero")

# Shoot using mouse
func _input(event):
	if event.is_action_released("shoot"):
		shoot()

func shoot():
	if(attack_cooldown.is_stopped()):
		var spell_instance = preload("res://spells/Spell.tscn").instance()
		var spell_origin = get_spell_origin()
		var spell_dir = (get_global_mouse_position()-spell_origin).normalized()
		emit_signal("player_cast_spell", spell_instance, self, spell_origin, spell_dir)
		attack_cooldown.start()

func get_spell_origin():
	# chooses a node as the spell's origin
	if(player_dir.x > 0):
		return spell_origin_right.global_position
	elif(player_dir.x < 0):
		return spell_origin_left.global_position
	elif(player_dir.y > 0):
		return spell_origin_down.global_position
	else:
		return spell_origin_up.global_position

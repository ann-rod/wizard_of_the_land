extends RigidBody2D

export (int) var speed = 5
onready var kill_timer = $KillTimer
var direction = Vector2.ZERO
var spellcaster = null # must be set so a spell cant hurt its caster

func _ready():
	kill_timer.start()

func _physics_process(_delta):
	if(direction != Vector2.ZERO):
		var velocity = direction*speed
		global_position += velocity

func init_spell(spellcaster, dir):
	self.spellcaster = spellcaster
	self.direction = dir

func _on_KillTimer_timeout():
	# deletes spells that didn't hit a target
	queue_free()


# this is the function that handles hits for Player and Mob
func _on_Spell_area_entered(area):
	if(area != self.spellcaster and area.has_method("handle_hit")):
		area.handle_hit()
		queue_free()

#func _on_Spell_body_entered(body):
#	if(body.has_method("handle_hit")):
#		body.handle_hit()
#		queue_free()

func _on_Spell_body_entered(body):
	if body.is_in_group("trees"):
		print("hit tree 1")
		queue_free()
	if(body != self.spellcaster and body.has_method("handle_hit")):
		body.handle_hit()
		queue_free()
	

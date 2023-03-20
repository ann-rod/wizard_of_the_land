extends Node2D

signal state_changed(new_state)
signal attempt_to_shoot(target_pos)
signal chase_target(target_pos)

enum State {
	PATROL,
	ENGAGE
}

onready var player_detection_zone = $PlayerDetectionZone
var current_state = State.PATROL setget set_state
var player = null

func _process(_delta):
	match current_state:
		State.PATROL:
			emit_signal("chase_target", Vector2.ZERO)
		State.ENGAGE:
			if(player != null):
				emit_signal("attempt_to_shoot", player.global_position)
				emit_signal("chase_target", player.global_position)
			else:
				print("in engage state but no weapon or player")
		_:
			print("Error: found state for enemy that should not exist.")

func set_state(new_state: int):
	if(new_state == current_state):
		return
	else:
		current_state = new_state
		emit_signal("state_changed", current_state)

func _on_PlayerDetectionZone_area_entered(area):
	if(area.is_in_group("player")):
		set_state(State.ENGAGE)
		player = area

func _on_PlayerUndetectZone_area_exited(area):
	if(area.is_in_group("player")):
		set_state(State.PATROL)
		player = null


func _on_Mob_under_attack(player_area):
	set_state(State.ENGAGE)
	self.player = player_area

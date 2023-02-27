extends Node2D

signal state_changed(new_state)
signal attempt_to_shoot(target_pos)

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
			pass
		State.ENGAGE:
			if(player != null):
				emit_signal("attempt_to_shoot", player.global_position)
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

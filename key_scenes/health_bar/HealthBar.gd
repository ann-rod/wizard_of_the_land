extends Control

onready var health_over = $HealthBarOver
onready var health_under = $HealthBarUnder
onready var update_tween = $HealthUpdateTween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red

export (float, 0, 1, .05) var caution_zone = .68
export (float, 0, 1, .05) var danger_zone = .35

func _ready():
	pass

func _on_health_updated(health):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	
	_assign_color(health)

func _assign_color(health):
	if(health < health_over.max_value * danger_zone):
		health_over.tint_progress = danger_color
	elif(health < health_over.max_value * caution_zone):
		health_over.tint_progress = caution_color
	else:
		health_over.tint_progress = healthy_color

func _on_max_health_updated(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health

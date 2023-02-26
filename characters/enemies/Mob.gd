extends Area2D
#onready var player = $Player
signal mob_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func handle_hit(_body):
	queue_free()
	emit_signal("mob killed")

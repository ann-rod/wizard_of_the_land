extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuButton.hide()
	yield(get_tree().create_timer(1.5), "timeout")
	$MenuButton.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MenuButton_pressed():
	get_tree().change_scene("res://environments/cabin/cabin.tscn")

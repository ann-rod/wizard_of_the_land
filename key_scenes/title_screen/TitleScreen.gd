extends Node2D

onready var bgRect = $Background
onready var logo = $GameLogo
onready var tutorial_button = $TutorialButton
onready var start_button = $StartButton
export (PackedScene) var Star

var bg_start_color = Vector3(1, 1, 1)
var bg_end_color = Vector3(.090, .011, .23)

var t = 0.0
var COLOR_CHANGE_SPEED = .3
var num_stars = 150
var screen_size

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	$TitleTheme.play()
	spawnStars(num_stars)
	logo.raise()

func _physics_process(delta):
	t += delta * COLOR_CHANGE_SPEED
	bgRect.color = lerp_bg_color(t)

func spawnStars(num_stars):
	for n in range(num_stars):
		var curr_star = preload("res://key_scenes/title_screen/Star.tscn").instance()
		var curr_pos = Vector2(rand_range(0, screen_size.x), rand_range(0, screen_size.y))
		curr_star.position = curr_pos
		curr_star.COLOR_CHANGE_SPEED = rand_range(.1, .9)
		add_child(curr_star)

func lerp_1d(start, stop, step):
	return start + (stop - start) * step

func cos_interp(start, stop, step):
	return ((1-step)*start + step*stop)

func lerp_bg_color(step):
	var curr_r = clamp(lerp_1d(bg_start_color.x, bg_end_color.x, step), bg_end_color.x, bg_start_color.x)
	var curr_g = clamp(lerp_1d(bg_start_color.y, bg_end_color.y, step), bg_end_color.y, bg_start_color.y)
	var curr_b = clamp(lerp_1d(bg_start_color.z, bg_end_color.z, step), bg_end_color.z, bg_start_color.z)
	return Color(curr_r, curr_g, curr_b, 1)

func _on_StartButton_pressed():
	$TitleTheme.stop()
	get_tree().change_scene("res://key_scenes/main/Main.tscn")

func _on_TutorialButton_pressed():
	$TitleTheme.stop()
	get_tree().change_scene("res://environments/tutorial/Tutorial.tscn")

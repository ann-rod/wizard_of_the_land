extends Sprite

var color_hsv = Vector3(.1, 0.3102, 0.96078)
var min_brightness = 0.2
var max_brightness = 1.0

var start_color = Color.from_hsv(color_hsv.x, color_hsv.y, color_hsv.z, min_brightness)
var end_color = Color.from_hsv(color_hsv.x, color_hsv.y, color_hsv.z, max_brightness)

var t = 0.0
var COLOR_CHANGE_SPEED = .25

func _ready():
	pass

func _physics_process(delta):
	t += delta * COLOR_CHANGE_SPEED
	self.modulate = Color.from_hsv(color_hsv.x, color_hsv.y, color_hsv.z, cos_interp_brightness(t))

func cos_interp_brightness(step):
	var t2 = (1-cos(PI*step))/2
	return ((1-t2)*min_brightness + t2*max_brightness)


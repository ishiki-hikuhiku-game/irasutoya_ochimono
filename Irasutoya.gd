extends RigidBody2D

var started = false
var ended = false

@onready var game = $"/root/Node2D/Game"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.gravity_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		return
	if game.over:
		linear_velocity = Vector2(0, 0)
		return
	if Input.is_action_pressed("ui_left"):
		set_axis_velocity(Vector2(-delta * 10000, 0))
	elif Input.is_action_pressed("ui_right"):
		set_axis_velocity(Vector2(delta * 10000, 0))
	elif Input.is_action_just_pressed("ui_down"):
		# set_axis_velocity(Vector2(0, 0))
		linear_velocity = Vector2(0, 0)
		self.gravity_scale = 1
		self.contact_monitor = true
		self.max_contacts_reported = 1
		started = true
		game.count_up()
	else:
		linear_velocity = Vector2(0, 0)


func _on_body_entered(_body):
	if started:
		ended = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	var gameover = $"/root/Node2D/UI/TextGameover"
	gameover.z_index = 200
	gameover.visible = true
	game.over = true

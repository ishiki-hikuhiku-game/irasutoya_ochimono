extends RigidBody2D

var started = false
var ended = false

@onready var game = $"/root/Node2D/Game"

# Called when the node enters the scene tree for the first time.
func _init():
	self.gravity_scale = 0


func _ready():
	disableCollision(true)


func disableCollision(disabled: bool):
	$"CollisionPolygon2D".disabled = disabled
	var index = 1
	var collision = get_node("CollisionPolygon2D" + var_to_str(index))
	while collision != null:
		collision.disabled = disabled
		index += 1
		collision = get_node("CollisionPolygon2D" + var_to_str(index))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		return
	if game.overed:
		linear_velocity = Vector2(0, 0)
		return
	if Input.is_action_pressed("ui_left"):
		set_axis_velocity(Vector2(-delta * 10000, 0))
	elif Input.is_action_pressed("ui_right"):
		set_axis_velocity(Vector2(delta * 10000, 0))
	elif Input.is_action_just_pressed("ui_down"):
		disableCollision(false)
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
	game.over()

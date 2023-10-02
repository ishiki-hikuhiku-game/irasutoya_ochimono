extends Node

var irasutoya1 = preload("res://irasutoya1.tscn")
var irasutoya2 = preload("res://irasutoya2.tscn")

var irasutoyas = [irasutoya1, irasutoya2]
var current_irasutoya = null
var over = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	elif over:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
	elif current_irasutoya == null or current_irasutoya.ended:
		var next_index = randi() % irasutoyas.size()
		current_irasutoya = irasutoyas[next_index].instantiate()
		get_parent().add_child(current_irasutoya)
		current_irasutoya.position = Vector2(600, 100)

extends Node

var irasutoya1 = preload("res://irasutoya1.tscn")
var irasutoya2 = preload("res://irasutoya2.tscn")

var irasutoyas = [irasutoya1, irasutoya2]
var current_irasutoya = null
var overed = false
var count = 0
var count_format = "%d個"
var high_score = 0
var FILE_NAME = "user://score.dat"
var score_format = "ハイスコア:%d個"
@onready var countLabel = $"/root/Node2D/UI/CountLabel"
@onready var scoreLabel = $"/root/Node2D/UI/ScoreLabel"

func _init():
	var score = load_score()
	if score != null:
		high_score = score


func _ready():
	if high_score:
		scoreLabel.text = score_format % high_score


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	elif overed:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
	elif current_irasutoya == null or current_irasutoya.ended:
		var next_index = randi() % irasutoyas.size()
		current_irasutoya = irasutoyas[next_index].instantiate()
		get_parent().add_child(current_irasutoya)
		current_irasutoya.position = Vector2(600, 100)

func count_up():
	count += 1
	countLabel.text = count_format % count


func save_score():
	if count > high_score:
		high_score = count
		var file = FileAccess.open(FILE_NAME, FileAccess.WRITE)
		file.store_64(high_score)


func load_score():
	var file = FileAccess.open(FILE_NAME, FileAccess.READ)
	if file:
		return file.get_64()


func over():
	overed = true
	var gameover = $"/root/Node2D/UI/TextGameover"
	gameover.z_index = 200
	gameover.visible = true
	save_score()

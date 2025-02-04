extends Node

var playerScore = 0
var cpuScore = -1
var isGameOver
@export var winScore = 5
@onready var pressR = $PressR
@onready var playerLabel = $playerScore
@onready var cpuLabel = $cpuScore
@onready var winner = $Winner

func _ready():
	isGameOver = false
	winner.visible = false
	pressR.visible = false
	pass

func _input(_event):
	restart()

func playerGoal():
	playerScore += 1
	playerLabel.text = str(playerScore)
	if playerScore == winScore:
		Game_Over()

func cpuGoal():
	cpuScore += 1
	cpuLabel.text = str(cpuScore)
	if cpuScore == winScore:
		Game_Over()

func restart():
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func Game_Over():
	isGameOver = true
	winner.visible = true
	pressR.visible = true
	if (cpuScore > playerScore):
		winner.text = "You Lose..."
	else:
		winner.text = "You Win!"

extends CharacterBody2D


@export var speed = 150
@export var boundary = 108
var gameOver = false

static var posX = -135

func get_input():
	var input_direction = Input.get_vector("null", "null", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	position.y = clamp(position.y, -boundary, boundary)
	position.x = posX
	get_input()
	move_and_slide()

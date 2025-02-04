extends CharacterBody2D

@export var speed = 150
@export var boundary = 108

static var posX = 135

func _physics_process(_delta):
	#find the ball Y value
	var ball = $"../ball"
	var ballPos = ball.position
	var ballDirection = position.y - ballPos.y
	#limit paddle movement to screen boundary
	position.y = clamp(position.y, -boundary, boundary)
	position.x = posX
	if ballDirection < 16 && ballDirection > -16:
		velocity.y = 0 * speed
	elif ballDirection < -16:
		velocity.y = 1 * speed
	elif ballDirection > 16:
		velocity.y = -1 * speed
	move_and_slide()

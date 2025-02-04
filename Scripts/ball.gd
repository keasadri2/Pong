extends RigidBody2D

@onready var anim = $AnimatedSprite2D
@onready var playerPaddle = $"../PlayerPaddle"
@onready var aiPaddle = $"../aiPaddle"
@onready var game_manager = %GameManager

#True = blue ball
#False = red ball
var ballColor

#Movement and speed
var speed
var maxSpeed = 500
var velocity = Vector2.ZERO

#randomizes 4 possible starting velocities for the ball as the game starts
func _ready():
	position = Vector2.ZERO
	speed = 0
	velocity = Vector2.ZERO
	await get_tree().create_timer(1.5).timeout
	speed = 200
	randomize()
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.3, 0.3][randi() % 2]
	# if the ball starts going right, play the animation that makes the ball blue
	# otherwise play the red animation
	if velocity.x > 0:
		anim.play("BlueTransition")
		ballColor = true
	else:
		anim.play("RedTransition")
		ballColor = false

func _physics_process(_delta):
	#uses move and collide function to store velocity and speed
	var collision_object = move_and_collide(velocity * speed * _delta)
	#when ball collides with an object (non specific) triggers paddlehit function
	if collision_object:
		velocity = velocity.bounce(collision_object.get_normal())
		var collider = collision_object.get_collider()
		_on_paddle_hit(collider)

#if ball hits a paddle determine which paddle
#and swap colors and ownership accordingly.
#also increase speed slightly per bounce.
func _on_paddle_hit(paddle):
	if paddle.is_in_group("Player") && ballColor == false:
		if speed < maxSpeed:
			speed += 15
		anim.play("BlueTransition")
		ballColor = true
	elif paddle.is_in_group("CPU") && ballColor == true:
		if speed < maxSpeed:
			speed += 15
		anim.play("RedTransition")
		ballColor = false

#when ball collides with the goal area
#reset the ball with the ready function
#update who got the point.
func _on_right_goal_body_entered(_body: Node2D) -> void:
	game_manager.playerGoal()
	if game_manager.isGameOver == false:
		_ready()

func _on_left_goal_body_entered(_body: Node2D) -> void:
	game_manager.cpuGoal()
	if game_manager.isGameOver == false:
		_ready()

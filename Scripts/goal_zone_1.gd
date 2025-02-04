extends Sprite2D


var speed = 20
var resetBound = -192

func _physics_process(_delta):
	position.y -= 1 * speed * _delta
	if position.y <= resetBound:
		position.y = 0

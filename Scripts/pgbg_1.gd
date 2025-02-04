extends Sprite2D

var bgResetBound = 192
var bgSpeed = 40

func _physics_process(_delta):
	#move the background
	position.y += 1 * bgSpeed * _delta
	if position.y >= bgResetBound:
		position.y = 0

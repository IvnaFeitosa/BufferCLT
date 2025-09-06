extends Node2D

var SPEED = 60
var direction = -1
@onready var rayCastUp = $RayCastUp
@onready var rayCastDown = $RayCastDown
@onready var animatedSprite = $AnimatedSprite2D
func _process(delta):
	if rayCastDown.is_colliding():
		direction = -1
		animatedSprite.play("backanim")
	if rayCastUp.is_colliding():
		direction = 1
		animatedSprite.play("frontanim")
	position.y += SPEED * delta * direction
	

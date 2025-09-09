extends PathFollow2D
@export var SPEED = 150.0
var direction = -1
@onready var rayCastUp = $RayCastUp
@onready var rayCastDown = $RayCastDown
@onready var animatedSprite = $AnimatedSprite2D
func _process(delta):
	'''
	if rayCastDown.is_colliding():
		direction = -1
		animatedSprite.play("backanim")
	if rayCastUp.is_colliding():
		direction = 1
		animatedSprite.play("frontanim")
	position.y += SPEED * delta * direction
	'''

func _physics_process(delta: float) -> void:
	progress += SPEED * delta
	if progress_ratio >= 1.0:
		gameManager.take_damage(1)
		queue_free() 

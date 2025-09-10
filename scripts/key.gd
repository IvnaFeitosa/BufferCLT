extends PathFollow2D
@export var SPEED = 100.0

@onready var animatedSprite = $AnimatedSprite2D
var previous_pos: Vector2

func _ready() -> void:
	previous_pos = global_position
	
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
	var dir := (global_position - previous_pos).normalized()
	print(dir)
	previous_pos = global_position
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			_set_animation("rightanim")
		else:
			_set_animation("leftanim")
	else:
		if dir.y > 0:
			_set_animation("downanim")
		else:
			_set_animation("upanim")
	if progress_ratio >= 0.97:
		gameManager.take_damage(1)
		queue_free() 
func _set_animation(name: String):
	if animatedSprite.animation != name:
		animatedSprite.play(name)

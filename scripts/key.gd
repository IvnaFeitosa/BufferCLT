extends PathFollow2D
@export var SPEED = 40.0
@export var HP = 2
@onready var animatedSprite = $AnimatedSprite2D
var previous_pos: Vector2

func _ready() -> void:
	previous_pos = global_position
	
func _physics_process(delta: float) -> void:
	progress += SPEED * delta
	var dir := (global_position - previous_pos).normalized()
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
	if progress_ratio >= 0.98:
		gameManager.take_damage(1)
		queue_free() 
		
func take_damage(dmg: int):
	print("damage took" + str(dmg))
	HP -= dmg
	if HP <= 0:
		die()
		
func die():
	gameManager.add_money(25)
	queue_free()
	
func _set_animation(anim_name: String):
	if animatedSprite.animation != anim_name:
		animatedSprite.play(anim_name)

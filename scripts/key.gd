extends PathFollow2D
class_name Key
const SPEED = 50.0
const money_reward = 25
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
		die()
		
func take_damage(dmg: int):
	HP -= dmg
	if HP <= 0:
		gameManager.add_money(money_reward)
		set_up_money_text()
		gameManager.add_enemy_killed(1)
		die()
		
func die():	
	remove_from_group("current_wave_enemies")
	gameManager.check_for_end_of_wave()
	call_deferred("queue_free")
func set_up_money_text():
	var text = preload("res://scenes/floatingText.tscn").instantiate()
	text.global_position = position
	text.float_text("+$" + str(money_reward))
	get_tree().get_root().add_child(text)
	
func _set_animation(anim_name: String):
	if animatedSprite.animation != anim_name:
		animatedSprite.play(anim_name)

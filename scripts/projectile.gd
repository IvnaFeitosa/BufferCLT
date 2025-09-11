extends Node2D
@onready var direction: Vector2
@onready var speed: float
@onready var dmg: int

func _setup(_direction:Vector2, _speed:float, _dmg: int):
	direction = _direction.normalized()
	speed = _speed
	dmg = _dmg
func _ready():
	$Timer.start()
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.get_parent().take_damage(dmg)
	queue_free()
		


func _on_timer_timeout() -> void:
	queue_free()

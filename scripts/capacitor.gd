extends Node2D
var data: TowerData
@onready var sfx = $sfx
func _ready():
	sfx.stream = data.projetile_sound
func _setup(tower_data:TowerData):
	data = tower_data
	$ShootTimer.wait_time = data.fire_rate
	call_deferred("_start_timer")
func _start_timer():
	$ShootTimer.start()


func _on_shoot_timer_timeout() -> void:
	if data == null :
		return
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies.size() > 0:
		var body = bodies[0]
		var bullet = data.projectile.instantiate()
		bullet.position = self.position
		var dir = (body.global_position - self.global_position)
		bullet._setup(dir,data.projectile_speed, 1)
		sfx.play()
		self.get_parent().add_child(bullet)

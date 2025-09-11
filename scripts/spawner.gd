extends Node2D
signal wave_finished_spawning
@export var stages: Array[Stage]
@onready var timer = $SpawnTimer
@onready var path = $StagePath
var rng = RandomNumberGenerator.new()
var current_sequence : int =   0
var stage
var waves

func _ready() -> void:
	gameManager.register_spawner(self)
	gameManager.connect("wave_changed", Callable(self, "_on_wave_change"))
	stage = stages[gameManager.stage]
	waves = stage.waves
	#flexing my abilities to be the dumbest person alive
	#timer.start(waves[gameManager.current_wave].enemy_sequences[current_sequence].time)
	gameManager.change_wave()

func _on_spawn_timer_timeout() -> void:
	var enemy_sequence = waves[gameManager.current_wave].enemy_sequences[current_sequence]
	for i in range(enemy_sequence.amount):
		var enemy = EnemyDB.scenes[enemy_sequence.name].instantiate()
		enemy.h_offset = -18 + (i%3)*18 + rng.randi_range(-5, 5)
		enemy.v_offset = i/3 * -18 +  rng.randi_range(-5, 5)
		#enemy.h_offset = 
		#enemy.v_offset = rng.randi_range(-20, 20)
		path.add_child(enemy)
		enemy.add_to_group("current_wave_enemies")
	# go to next sequence in wave
	print("current sequence", current_sequence)
	current_sequence+= 1	
	# if theres no more sequences then reset it and await next wave
	if current_sequence == waves[gameManager.current_wave].enemy_sequences.size():
		current_sequence = 0
		timer.stop()
		emit_signal("wave_finished_spawning")
		#gameManager.all_enemies_from_wave_spawned = true
	else:
		timer.start(waves[gameManager.current_wave].enemy_sequences[current_sequence].time)
	
func _on_wave_change(_new_wave):
	print("current wave", gameManager.current_wave)
	
	timer.start(waves[gameManager.current_wave].enemy_sequences[current_sequence].time)
	#gameManager.all_enemies_from_wave_spawned=false

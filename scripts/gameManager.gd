extends Node
signal wave_changed(new_value: int)
signal money_changed(new_value: int)
signal health_changed(new_value: int)
var spawner : Node = null
var stage_resource = preload("res://scripts/stage0.tres")
var results_screen = preload("res://scenes/results.tscn")
var money: int = 300
var health: int  = 10
var stage: int = 0
var enemies_killed: int = 0
var towers_bought: int = 0
var current_wave: int = -1
var max_wave = stage_resource.waves.size()
var all_enemies_from_wave_spawned : bool = false

func register_spawner(node:Node)->void:
	spawner = node
	spawner.wave_finished_spawning.connect(_on_wave_finished_spawning)

func add_money(new_val: int):
	money+= new_val
	emit_signal("money_changed", money)
	
func spend_money(cost: int) -> bool:
	if (money >= cost):
		money -= cost
		emit_signal("money_changed", money)
		return true
	return false
func add_enemy_killed(quantity: int):
	enemies_killed += quantity
func add_tower_bought(quantity: int):
	towers_bought += quantity
func take_damage(dmg: int):
	health -= dmg
	if (health <= 0):
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		emit_signal("health_changed", health)
func change_wave():
	current_wave+= 1
	if (current_wave == max_wave):
		call_deferred("change_scene_safe")
	else:
		emit_signal("wave_changed", current_wave)
	
func check_for_end_of_wave():
	if !get_tree().has_group("current_wave_enemies") and all_enemies_from_wave_spawned:
		all_enemies_from_wave_spawned = false
		change_wave()

func change_scene_safe():
	get_tree().get_root().add_child(results_screen.instantiate())
	
func _on_wave_finished_spawning():
	all_enemies_from_wave_spawned = true
##better in a utility script mas eu to com pressaaaaa
func tween_number(label: Label, from_value: int, to_value: int, duration: float):
	var tween := label.create_tween()
	tween.tween_method(
		func(value): label.text = str(int(value)),
		from_value,
		to_value,
		duration
	)


## Reseta o estado do singleton
func reset():
	money = 300
	health  = 10
	stage = 0
	enemies_killed = 0
	towers_bought = 0
	current_wave = -1
	max_wave = stage_resource.waves.size()
	all_enemies_from_wave_spawned = false

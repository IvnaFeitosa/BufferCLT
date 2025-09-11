extends Node
var stage_resource = preload("res://scripts/stage0.tres")
var money: int = 300
var health: int  = 10
var stage: int = 0
var current_wave: int = -1
var max_wave = stage_resource.waves.size()
#var all_enemies_from_wave_spawned : bool = false
signal wave_changed(new_value: int)
signal money_changed(new_value: int)
signal health_changed(new_value: int)


func add_money(new_val: int):
	money+= new_val
	emit_signal("money_changed", money)
	
func spend_money(cost: int) -> bool:
	if (money > cost):
		money -= cost
		emit_signal("money_changed", money)
		return true
	return false

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
	if !get_tree().has_group("current_wave_enemies"):
		change_wave()

func change_scene_safe():
	get_tree().change_scene_to_file("res://scenes/results.tscn")

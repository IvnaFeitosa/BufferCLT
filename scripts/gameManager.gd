extends Node
var money: int = 1500
var health: int  = 10
signal money_changed(new_value: int)
signal health_changed(new_value: int)
signal died()

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
		emit_signal("died")
	else:
		emit_signal("health_changed", health)
	

extends Node
var money: int = 155
signal money_changed(new_value)
func add_money(new_val: int):
	money+= new_val
	emit_signal("money_changed", money)
func spend_money(cost: int) -> bool:
	if (money > cost):
		money -= cost
		emit_signal("money_changed", money)
		return true
	return false
	

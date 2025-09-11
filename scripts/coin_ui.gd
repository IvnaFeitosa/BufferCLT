extends Control
@onready var coin_counter = $coin_counter 

func _ready() -> void:
	gameManager.connect("money_changed", Callable(self, "_on_money_changed"))
	coin_counter.text = str(gameManager.money)
func _on_money_changed(money):
	var old_money = int(coin_counter.text)
	gameManager.tween_number(coin_counter, old_money, money, 0.2)
	

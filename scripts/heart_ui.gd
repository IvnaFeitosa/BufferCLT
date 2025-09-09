extends Control
@onready var heart_counter = $heart_counter
func _ready() -> void:
	gameManager.connect("health_changed", Callable(self, "_on_take_damage"))
	heart_counter.text = str(gameManager.health) + "/10"
func _on_take_damage(new_health):
	heart_counter.text = str(new_health) + "/10"
	

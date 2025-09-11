extends Control
@onready var wave_counter = $wave_counter
func _ready() -> void:
	gameManager.connect("wave_changed", Callable(self, "_on_wave_change"))
	wave_counter.text = str(gameManager.current_wave+1) + "/" + str(gameManager.max_wave)
func _on_wave_change(new_wave):
	wave_counter.text = str(new_wave+1) + "/" + str(gameManager.max_wave)
	

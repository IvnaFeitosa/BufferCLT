extends Control
@onready var wave_counter = $wave_counter
@onready var warning = $warning
@onready var warning_shadow = $warning/warningShadow
@onready var anim_text = $AnimationPlayer
@onready var sfx = $SFX
func _ready() -> void:
	gameManager.connect("wave_changed", Callable(self, "_on_wave_change"))
	wave_counter.text = "1/" + str(gameManager.max_wave)
	warning.visible = false
func _on_wave_change(new_wave):
	wave_counter.text = str(new_wave+1) + "/" + str(gameManager.max_wave)
	warning.text = "WAVE " + str(new_wave+1) + "!"
	warning_shadow.text = "WAVE " + str(new_wave+1) + "!"
	sfx.play()
	anim_text.play("text anim")
	

extends Control
@onready var clipboard_text = $Clipboard.get_children()
@onready var grade_falling = $GradeFalling
@onready var grade = $Grade
@onready var sfx = $SFX
func _ready() -> void:
	sfx.play()
	for text in clipboard_text:
		text.visible = false
	
	


func _on_start_up_animation_finished(_anim_name: StringName) -> void:
	for text in clipboard_text:
		text.visible = true
	gameManager.tween_number($Clipboard/towersNum, 0, gameManager.towers_bought, 0.2)
	gameManager.tween_number($Clipboard/enemiesNum, 0, gameManager.enemies_killed, 0.3)
	gameManager.tween_number($Clipboard/moneyNum, 0, gameManager.money, 0.4)
	grade.visible = true
	grade_falling.play("grade_falling")


func _on_grade_falling_animation_finished(_anim_name: StringName) -> void:
	pass # Replace with function body.


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")
	grade.visible = false

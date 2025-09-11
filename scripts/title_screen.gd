extends Control

var menu_items = []
var selected_index = 0
@onready var selector = $Selector
@onready var background_img = $Background
@onready var ok_sfx = $okSFX
@onready var select_sfx = $selectSFX
func _ready():
	background_img.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR

	menu_items = $Menu.get_children()
	update_selection()

func _input(event):
	if event.is_action_pressed("ui_down"):
		select_sfx.play()
		selected_index = (selected_index + 1) % menu_items.size()
		update_selection()
	elif event.is_action_pressed("ui_up"):
		select_sfx.play()
		selected_index = (selected_index - 1 + menu_items.size()) % menu_items.size()
		update_selection()
	elif event.is_action_pressed("ui_accept"):
		ok_sfx.play()
		await ok_sfx.finished
		execute_option()

func update_selection():
	for i in range(menu_items.size()):
		if i == selected_index:
			menu_items[i].add_theme_color_override("font_color", Color.WHITE)
			selector.position.y = menu_items[i].global_position.y
		else:
			menu_items[i].add_theme_color_override("font_color", Color.BLACK)

func execute_option():
	match selected_index:
		0:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
		1:
			get_tree().change_scene_to_file("res://scenes/phase2.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/select_phase.tscn")
		3:
			get_tree().quit()

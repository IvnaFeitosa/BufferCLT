extends Control

var options = []
var selected_index = 0
var arrow

func _ready():
	
	options = $Menu.get_children()
	# options.remove_at(0) 
	
	arrow = Label.new()
	arrow.text = "▶"
	add_child(arrow)

	arrow.add_theme_color_override("font_color", Color8(136,199,113,255))
	update_arrow_position()


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_index = (selected_index + 1) % options.size()
		update_arrow_position()

	elif Input.is_action_just_pressed("ui_up"):
		selected_index = (selected_index - 1 + options.size()) % options.size()
		update_arrow_position()

	elif Input.is_action_just_pressed("ui_accept"):
		execute_option()


func update_arrow_position():
	for opt in options:
		opt.add_theme_color_override("font_color", Color.WHITE)

	var selected_label = options[selected_index]

	selected_label.add_theme_color_override("font_color",  Color8(136,199,113,255))


	var pos = selected_label.get_global_position()
	arrow.global_position = Vector2(
		pos.x - 30,
		pos.y + selected_label.size.y / 2 - arrow.size.y / 2
	)
	
	
func execute_option():
	match selected_index:
		0:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
		1:
			
			get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")
		2:
			
			get_tree().quit()

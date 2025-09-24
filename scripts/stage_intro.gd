extends Control
@onready var ok_sfx = $okSFX
@onready var go_sfx = $goSFX
var panels: Array
var current_stage: int
var current_stage_char_pos: Array[Vector2i]
var current_panel: int = 0
var tween
var tween_time = 1
var initial_pos: Array
func _ready() -> void:
	current_stage = gameManager.current_stage
	current_stage_char_pos = gameManager.stage_resource.intro_char_pos
	panels = get_tree().get_nodes_in_group("fixedpanel")
	for panel in panels:
		initial_pos.append(panel.position.y)
	for i in 4:
		var new_panel = TextureRect.new()
		new_panel.name = "char" + str(i)
		new_panel.texture = load("res://assets/story/stage/"+ str(current_stage) +"/"+str(i+1)+".png")
		new_panel.position = current_stage_char_pos[i]
		panels[i+1].add_child(new_panel)
		panels[i+1].move_child(new_panel,0)
	animate_panel(panels[current_panel])

	
func animate_panel(panel):
	tween = create_tween()
	tween.parallel().tween_property(panel, "position:y",panel.position.y, tween_time).from(panels[current_panel].position.y-50).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(panel , "modulate:a", 1, tween_time).set_trans(Tween.TRANS_SINE)
	if current_panel == 6:
		go_sfx.play()
		$Panel6/goRect/AnimationPlayer.play("shake")
	current_panel+=1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var sfx = ok_sfx.duplicate()
		sfx.connect("finished", Callable(sfx, "queue_free"))
		get_tree().root.add_child(sfx)
		sfx.play()
		#skip tween
		tween.custom_step(tween_time+0.1)
		#reset timer for next panel to appear
		$Timer.start()
		#if the player skip one tween the next one starts immediately after
		advance_panel()
		
	elif event.is_action_pressed("ui_cancel"):
		if tween and tween.is_running():
			tween.stop()
		for i in range(0, 7):
			panels[i].modulate.a = 1
			panels[i].position.y = initial_pos[i]
		current_panel = 7
func advance_panel():
	if current_panel < 7:
		animate_panel(panels[current_panel])
	elif current_panel == 7:
		current_panel += 1
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
func _on_timer_timeout() -> void:
	if current_panel < 7:
		#if current_panel == 4:
		#	animate_panel(panels[current_panel])
		animate_panel(panels[current_panel])
	else:
		$Timer.stop()

func _on_skip_button_pressed() -> void:
	$SkipButton/AnimatedSprite2D.play("press")
func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

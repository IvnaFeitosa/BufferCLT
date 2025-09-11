extends Node2D

func float_text(n_text: String):
	var label = $Label
	#var anim: AnimationPlayer = $AnimationPlayer
	#label.text = n_text
	#anim.play("fadeout")
	label.text=n_text
	var tween := create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -30), 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "modulate",Color(1,1,1,0), 0.6)
	tween.tween_callback(queue_free)

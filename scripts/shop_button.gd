extends Button
@onready var anim = $AnimationPlayer
@onready var ok_sfx = $okSFX
@onready var no_sfx = $noSFX
signal tower_bought(data)
var tower_data: TowerData

func setup(data: TowerData):
	tower_data = data
	$Name.text = data.name
	$Cost.text = data.cost
	$TextureRect.texture = data.icon
func _pressed():
	if (gameManager.spend_money(tower_data.cost.to_int())):
		remove_child(ok_sfx)
		get_tree().current_scene.add_child(ok_sfx)
		ok_sfx.play()
		ok_sfx.connect("finished",queue_free)
		emit_signal("tower_bought", tower_data)
	else:
		no_sfx.play()
		var tween = create_tween()
		anim.play("shake")
		tween.tween_property(self, "modulate",Color.RED, 0.2).set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "modulate",Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE)

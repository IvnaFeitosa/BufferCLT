extends Node2D
@onready var spotlight = $PointLight2D
@onready var shop_scene: PackedScene = preload("res://scenes/shop.tscn")

func _on_static_body_2d_mouse_entered() -> void:
	spotlight.visible = true
	

func _on_static_body_2d_mouse_exited() -> void:
	spotlight.visible = false

func _on_static_body_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		var shop = shop_scene.instantiate()
		shop.set_spot(self)
		get_tree().root.add_child(shop)
		

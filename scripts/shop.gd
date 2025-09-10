extends Control

@export var tower_data: Array[TowerData]
@export var button_scene: PackedScene
var current_spot: Node = null

func set_spot(spot: Node):
	current_spot = spot

func _ready() -> void:
	for data in tower_data:
		var btn = button_scene.instantiate()
		btn.setup(data)
		btn.connect("tower_bought", Callable(self, "_on_tower_bought"))
		$GridContainer.add_child(btn)

func _on_close_menu_bttn_pressed() -> void:
	queue_free()
	
func _on_tower_bought(data: TowerData):
	var tower = data.scene.instantiate()
	tower._setup(data)
	tower.position = current_spot.position
	tower.position.y -= 20

	current_spot.get_parent().add_child(tower)
	current_spot.queue_free();
	queue_free();

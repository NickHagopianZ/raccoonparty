extends Button

@export var target_parent : Control
@export var new_scene : PackedScene


func _ready() -> void:
	target_parent.child_order_changed.connect(_on_child_order_changed)

func _pressed() -> void:
	GameManager.play_sfx.emit(GameManager.SFX.Interact)
	var new_ui_instance = new_scene.instantiate()
	for child in target_parent.get_children():
		child.visible = false
	target_parent.add_child(new_ui_instance)


func _on_child_order_changed() -> void:
	if target_parent.get_child_count() == 0:
		return
	var last_child = target_parent.get_child(-1)
	last_child.visible = true

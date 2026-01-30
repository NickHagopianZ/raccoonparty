extends Control

var current_drag_card: Card = null


func _ready() -> void:
	mouse_exited.connect(_on_mouse_exited)


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if data is Card:
		current_drag_card = data
		data.playable = true
		return true
	return false


func _drop_data(_at_position: Vector2, data) -> void:
	current_drag_card = null
	if data is Card:
		data.play()


func _on_mouse_exited() -> void:
	if current_drag_card and is_instance_valid(current_drag_card):
		current_drag_card.playable = false
		current_drag_card = null

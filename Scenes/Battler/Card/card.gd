extends ColorRect
class_name Card

var hovered : bool = false
var held : bool = false
var playable : bool = false
var drag_preview : Control = null
signal playing_card

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not held:
			# Will be handled by _get_drag_data when drag starts
			pass
		elif not event.pressed and not held:
			# Clicked without dragging - play the card
			playing_card.emit()


func _process(_delta: float) -> void:
	# Update preview appearance based on playable state
	if held and drag_preview and is_instance_valid(drag_preview):
		if playable:
			# Bright glow effect when over drop zone
			drag_preview.modulate = Color(1.5, 2.0, 1.5, 1.0)
			drag_preview.scale = Vector2(1.1, 1.1)
		else:
			drag_preview.modulate = Color(1, 1, 1, 0.8)
			drag_preview.scale = Vector2.ONE


func play() -> void:
	playing_card.emit()


func _get_drag_data(_at_position: Vector2):
	held = true
	GameManager.dragging = true
	
	# Create a container to offset the preview so mouse is centered
	var container = Control.new()
	drag_preview = duplicate()
	drag_preview.modulate = Color(1, 1, 1, 0.8)
	drag_preview.position = -size / 2  # Offset so the mouse is at the center
	drag_preview.pivot_offset = size / 2  # Scale from center
	container.add_child(drag_preview)
	set_drag_preview(container)
	
	# Hide the original while dragging
	modulate.a = 0.3
	
	return self


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		held = false
		playable = false
		drag_preview = null
		GameManager.dragging = false
		# Restore visibility
		modulate.a = 1.0

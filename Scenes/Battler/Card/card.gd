extends ColorRect
class_name Card

var hovered : bool = false
var held : bool = false
var playable : bool = false
var drag_preview : Control = null
signal playing_card
# accessible statically
const CARD_SIZE = Vector2(250, 350)
func _ready() -> void:
	size = CARD_SIZE
	global_position = get_parent().global_position + get_parent().get_rect().size / 2 - CARD_SIZE / 2


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not held:
			# Will be handled by _get_drag_data when drag starts
			pass
		elif not event.pressed and not held:
			# Clicked without dragging - play the card
			playing_card.emit()


func _process(_delta: float) -> void:
	update_visuals()


func play() -> void:
	playing_card.emit()


func _get_drag_data(_at_position: Vector2):
	held = true
	GameManager.dragging = true
	
	# Create a container to offset the preview so mouse is centered
	var container = Control.new()
	drag_preview = duplicate()
	drag_preview.rotation = 0.0  # Reset rotation for preview
	drag_preview.modulate = Color(1, 1, 1, 0.8)
	drag_preview.position = -CARD_SIZE / 2  # Offset so the mouse is at the center
	drag_preview.pivot_offset = CARD_SIZE / 2  # Scale from center
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


func update_visuals() -> void:
	if held:
		modulate = Color(1, 1, 1, .3)
		if drag_preview and is_instance_valid(drag_preview):
			if playable:
				# Bright glow effect when over drop zone
				drag_preview.self_modulate = Color(2, 2, 2, 1)
				drag_preview.scale = Vector2(1.1, 1.1)
			else:
				drag_preview.self_modulate = Color(1, 1, 1, 1)
				drag_preview.scale = Vector2.ONE
	elif hovered:
		modulate = Color(2, 2, 2, 1)
		z_index = 1
	else:
		modulate = Color(1, 1, 1, 1)
		z_index = 0


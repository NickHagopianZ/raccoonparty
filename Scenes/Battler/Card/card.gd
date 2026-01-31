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


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not held:
			# Will be handled by _get_drag_data when drag starts
			pass
		elif not event.pressed and not held:
			# Clicked without dragging - play the card
			play()


func _process(_delta: float) -> void:
	update_visuals()


func play() -> void:
	if GameManager.can_play_cards:
		playing_card.emit()


func _get_drag_data(_at_position: Vector2):
	if not GameManager.can_play_cards:
		return null
	held = true
	GameManager.dragging = true

	# Create a container to offset the preview so mouse is centered
	var container = Control.new()
	drag_preview = duplicate()

	# Reset all layout properties that might interfere
	drag_preview.set_anchors_preset(Control.PRESET_BOTTOM_LEFT, true)
	drag_preview.rotation = 0.0
	drag_preview.modulate = Color.WHITE

	# drag_preview.set_position(-CARD_SIZE * preview_scale / 2)
	drag_preview.position.x = -CARD_SIZE.x * scale.x / 2
	drag_preview.position.y = -CARD_SIZE.y * scale.y / 2
	container.add_child(drag_preview)
	set_drag_preview(container)
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
	if held and GameManager.can_play_cards:
		modulate = Color(1, 1, 1, .3)
		if drag_preview and is_instance_valid(drag_preview):
			if playable:
				# Bright glow effect when over drop zone
				drag_preview.self_modulate = Color(2, 2, 2, 1)
				# drag_preview.scale = Vector2(1.1, 1.1)
			else:
				drag_preview.self_modulate = Color.WHITE
				# drag_preview.scale = Vector2.ONE
	elif hovered and GameManager.can_play_cards:
		modulate = Color(2, 2, 2, 1)
		z_index = 1
	else:
		modulate = Color.WHITE
		z_index = 0

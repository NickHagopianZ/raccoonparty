extends Control
class_name ControlPopup

@export var close_button : Button
func _ready() -> void:
	top_level = true
	z_index = 1
	set_anchors_preset(Control.PRESET_FULL_RECT, true)
	if close_button:
		close_button.pressed.connect(close)


func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		close()

func close() -> void:
	visible = false
	queue_free()

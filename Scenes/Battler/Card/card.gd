extends ColorRect
class_name Card

var card_container: CardContainer
var hovered : bool = false

func _gui_input(event):
	if event.is_action_pressed("left_click"):
		card_container.play_card()

func _ready():
	size = Vector2(250, 350) * 1.0

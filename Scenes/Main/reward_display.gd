extends Control

@export var close_button : Button
@export var card_container : HBoxContainer

func _ready() -> void:
	visible = false
	close_button.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed() -> void:
	visible = false
	# End interaction after selection
	GameManager.end_interaction()


func display_cards(cards : Array[CardContainer]) -> void:
	visible = true
	# clear children
	for child in card_container.get_children():
		card_container.remove_child(child)
		child.queue_free()

	for card in cards:
		card_container.add_child(card)

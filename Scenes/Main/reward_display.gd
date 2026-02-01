extends Control

@export var close_button : Button
@export var card_display_container : HBoxContainer

func _ready() -> void:
	visible = false
	close_button.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed() -> void:
	visible = false
	# End interaction after selection
	GameManager.end_interaction()


func display_cards(cards : Array[CardResource]) -> void:
	visible = true
	# clear children
	for child in card_display_container.get_children():
		card_display_container.remove_child(child)
		child.queue_free()

	for card in cards:
		var card_container: CardContainer = Deck.CARD_SCENE.instantiate()
		card_container.set_card(card)
		card_display_container.add_child(card_container)

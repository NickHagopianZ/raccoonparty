extends Control

@export var close_button : Button
@export var card_display_container : HBoxContainer

func _ready() -> void:
	visible = false
	close_button.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed() -> void:
	GameManager.can_play_cards = true
	visible = false
	# End interaction after selection
	GameManager.end_interaction()
	GameManager.food_counter += 1


func display_cards(cards : Array[CardResource]) -> void:
	GameManager.can_play_cards = true

	visible = true
	# clear children
	for child in card_display_container.get_children():
		card_display_container.remove_child(child)
		child.queue_free()

	for card in cards:
		var card_container: CardContainer = Deck.CARD_SCENE.instantiate()
		card_container.set_card(card)
		card_display_container.add_child(card_container)

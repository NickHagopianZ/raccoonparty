extends HBoxContainer



func _ready() -> void:
	var player_deck = GameManager.player_deck
	player_deck.update_cards.connect(_on_update_cards)
	_on_update_cards()


func _on_update_cards() -> void:
	var hand = GameManager.player_deck.hand
	for card in hand:
		if not card.is_inside_tree():
			add_child(card)
	for i in get_children():
		if i not in hand:
			remove_child(i)
			i.queue_free()
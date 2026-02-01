extends Node


func _ready() -> void:
	save_all_possible_cards()

func save_all_possible_cards() -> void:
	var all_possible_cards = AllPossibleCards.new()
	for card : CardResource in all_possible_cards.card_list:
		var card_name = card.title.replace(" ", "_").replace("?", "").replace("!", "").replace(".", "").to_lower()
		var file_path = "res://Resources/Cards/%s.tres" % card_name
		ResourceSaver.save(card, file_path)

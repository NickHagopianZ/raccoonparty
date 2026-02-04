extends Node


func _ready() -> void:
	save_all_possible_cards()
	save_all_possible_rumors()
	save_all_possible_penalties()
	get_tree().quit()

func save_all_possible_cards() -> void:
	var all_possible_cards = AllPossibleCards.new()
	for card : CardResource in all_possible_cards.basic_card_list:
		print(card.title)
		var card_name = card.title.replace(" ", "_").replace("?", "").replace("!", "").replace(".", "").to_lower()
		var file_path = "res://Resources/Cards/%s.tres" % card_name
		ResourceSaver.save(card, file_path)


func save_all_possible_rumors() -> void:
	var all_possible_cards = AllPossibleCards.new()
	var prefix = "rumor_"
	for card : CardResource in all_possible_cards.rumor_card_list:
		print(card.title)
		var card_name = prefix + card.title.replace(" ", "_").replace("?", "").replace("!", "").replace(".", "").to_lower()
		var file_path = "res://Resources/Cards/%s.tres" % card_name
		ResourceSaver.save(card, file_path)

func save_all_possible_penalties() -> void:
	var all_possible_cards = AllPossibleCards.new()
	var prefix = "penalty_"
	for card : CardResource in all_possible_cards.penalty_card_list:
		print(card.title)
		var card_name = prefix + card.title.replace(" ", "_").replace("?", "").replace("!", "").replace(".", "").to_lower()
		var file_path = "res://Resources/Cards/%s.tres" % card_name
		ResourceSaver.save(card, file_path)

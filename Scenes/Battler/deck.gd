extends Node

const hand_size = 2

var deck: Array[CardResource]
var hand: Array[Card]
var discard: Array[CardResource]
var draw_pile: Array[CardResource]

const CARD_SCENE = preload("res://Scenes/Battler/Card/card.tscn")

func add_card_to_deck(card_resource: CardResource):
	#var card: Card = CARD_SCENE.instantiate()
	#card.set_card(card_resource)
	#add_child(card)
	deck.append(card_resource)

func _ready():
	deck = []

	add_card_to_deck(AllPossibleCards.sip_drink)
	add_card_to_deck(AllPossibleCards.growl)
	add_card_to_deck(AllPossibleCards.backflip)

	prepare_for_battle()

func prepare_for_battle():
	hand = []
	discard = []
	draw_pile = deck.duplicate()
	draw_pile.shuffle()
	fill_hand()

func _try_fill_hand_from_draw_pile():
	while len(hand) < hand_size && len(draw_pile) > 0:
		var card_resource = draw_pile.pop_back()

		var card: Card = CARD_SCENE.instantiate()
		add_child(card)
		card.set_card(card_resource)
		card.set_index(len(hand))
		card.played.connect(play_card)

		hand.append(card)

func fill_hand():
	_try_fill_hand_from_draw_pile()

	if len(hand) < hand_size:
		draw_pile = discard.duplicate()
		discard = []
		draw_pile.shuffle()

	_try_fill_hand_from_draw_pile()

func play_card(index: int):
	var card = hand.pop_at(index)
	# TODO: Not sure if duplicate() is needed here
	discard.append(card.card_resource.duplicate())
	card.queue_free()

	for i in range(index, hand.size()):
		hand[i].set_index(i)

	if len(hand) == 0:
		fill_hand()

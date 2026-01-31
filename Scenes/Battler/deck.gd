extends Node
class_name Deck

const HAND_SIZE = 3
const MAX_DECK_SIZE = 10

var sideboard: Array[CardResource]
var deck: Array[CardResource]
var hand: Array[CardContainer]
var discard: Array[CardResource]
var draw_pile: Array[CardResource]

signal update_cards
signal card_played(card: CardContainer)
const CARD_SCENE = preload("res://Scenes/Battler/Card/card.tscn")


func add_card_to_deck(card_resource: CardResource):
	deck.append(card_resource)

# called as constructor
func _init():
	deck = []
	add_card_to_deck(AllPossibleCards.sip_drink)
	add_card_to_deck(AllPossibleCards.back_flip)
	add_card_to_deck(AllPossibleCards.jam)
	add_card_to_deck(AllPossibleCards.nice_shoes)
	add_card_to_deck(AllPossibleCards.nod_along)
	add_card_to_deck(AllPossibleCards.shots)
	add_card_to_deck(AllPossibleCards.podcasts)
	add_card_to_deck(AllPossibleCards.sewer)
	add_card_to_deck(AllPossibleCards.growl)
	add_card_to_deck(AllPossibleCards.hot_take)
	add_card_to_deck(AllPossibleCards.gonna_eat_that)
	add_card_to_deck(AllPossibleCards.garbage_man)
	add_card_to_deck(AllPossibleCards.have_we_met)
	add_card_to_deck(AllPossibleCards.distraction)
	add_card_to_deck(AllPossibleCards.good_old_days)

func _ready():
	reset_deck()

func reset_deck():
	hand = []
	discard = []
	draw_pile = deck.duplicate(true)
	draw_pile.shuffle()

	fill_hand()


# Returns True if a card was drawn, otherwise False
func draw_card() -> bool:
	if len(draw_pile) == 0 and len(discard) == 0:
		print("No cards left to draw!")
		return false
	elif len(draw_pile) == 0:
		shuffle_in_discard_pile()
	var card_resource = draw_pile.pop_back()

	var card: CardContainer = CARD_SCENE.instantiate()
	card.set_card(card_resource)
	card.played.connect(play_card)
	#card.played.connect(GameManager.player_character_played_card)

	hand.append(card)
	update_cards.emit()
	return true


func shuffle_in_discard_pile():
	draw_pile = discard.duplicate()
	discard = []
	draw_pile.shuffle()
	update_cards.emit()


func fill_hand():
	while len(hand) < HAND_SIZE:
		if not draw_card():
			# Not able to fill hand, i.e. desired hand size > total deck size
			break


func play_card(card):
	card_played.emit(card)
	discard.append(card.card_resource)
	hand.erase(card)
	card.queue_free()

	if len(hand) == 0:
		fill_hand()
	update_cards.emit()

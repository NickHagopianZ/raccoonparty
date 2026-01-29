extends Node
class_name Deck

const hand_size = 2

var deck: Array[CardResource]
var hand: Array[CardContainer]
var discard: Array[CardResource]
var draw_pile: Array[CardResource]

signal update_cards
const CARD_SCENE = preload("res://Scenes/Battler/Card/card.tscn")


func add_card_to_deck(card_resource: CardResource):
	deck.append(card_resource)

# called as constructor
func _init():
	deck = []
	# todo create a deck instance with these starting cards and save it
	add_card_to_deck(AllPossibleCards.sip_drink)
	add_card_to_deck(AllPossibleCards.growl)
	add_card_to_deck(AllPossibleCards.backflip)

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
	card.played.connect(GameManager.player_character_played_card)

	hand.append(card)
	update_cards.emit()
	return true


func shuffle_in_discard_pile():
	draw_pile = discard.duplicate()
	discard = []
	draw_pile.shuffle()
	update_cards.emit()


func fill_hand():
	while len(hand) < hand_size:
		if not draw_card():
			# Not able to fill hand, i.e. desired hand size > total deck size
			break


func play_card(card):
	discard.append(card.card_resource)
	hand.erase(card)
	card.queue_free()

	if len(hand) == 0:
		fill_hand()
	update_cards.emit()

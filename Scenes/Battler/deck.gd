extends Node
class_name Deck

const HAND_SIZE = 3
const MIN_DECK_SIZE = 10

var sideboard: Array[CardResource]
var deck: Array[CardResource]
var penalty_deck: Array[CardResource]
# Dictionary[npc_name: String, Array[CardResource]]
var rumor_deck: Dictionary
var hand: Array[CardContainer]
var discard: Array[CardResource]
var draw_pile: Array[CardResource]
var cards_discarded : int = 0

signal update_cards
signal card_played(card: CardContainer)
const CARD_SCENE = preload("res://Scenes/Battler/Card/card.tscn")

func add_card_to_penalty_deck(card_resource: CardResource):
	card_resource.card_type = CardResource.CARDTYPE.PENALTY
	penalty_deck.append(card_resource)


func add_card_to_rumor_deck(card_resource: CardResource, npc_names: Array[String]):
	card_resource.card_type = CardResource.CARDTYPE.RUMOR
	for npc_name in npc_names:
		if not rumor_deck.has(npc_name):
			rumor_deck[npc_name] = []
		rumor_deck[npc_name].append(card_resource)

func add_card_to_deck(card_resource: CardResource):
	card_resource.card_type = CardResource.CARDTYPE.NORMAL
	deck.append(card_resource)

# called as constructor
func _init():
	deck = []

func _ready():
	reset_deck()

func reset_deck(npc_name : String = ""):
	hand = []
	discard = []
	draw_pile = deck.duplicate(true)
	draw_pile.append_array(penalty_deck.duplicate(true))
	if npc_name != "" and npc_name in rumor_deck:
		draw_pile.append_array(rumor_deck[npc_name].duplicate(true))
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

	var card: CardContainer = create_card_container(card_resource)

	hand.append(card)
	update_cards.emit()
	return true


func create_card_container(card_resource: CardResource) -> CardContainer:
	var card: CardContainer = CARD_SCENE.instantiate()
	card.set_card(card_resource)
	card.played.connect(play_card)
	return card


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


func fill_hand_if_needed():
	if len(hand) == 0:
		fill_hand()


func play_card(card):
	card_played.emit(card)
	var exhaust_card := false
	for action in card.card_resource.actions:
		if action.effect == BattleScores.Effects.Exhaust:
			exhaust_card = true
			break
	hand.erase(card)
	if exhaust_card:
		if penalty_deck.has(card.card_resource):
			penalty_deck.erase(card.card_resource)
		elif deck.has(card.card_resource):
			deck.erase(card.card_resource)
	else:
		discard.append(card.card_resource)
	card.queue_free()

	update_cards.emit()

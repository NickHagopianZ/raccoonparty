extends ScrollContainer
class_name CardCollection

@export var card_count_node : Label
@export_enum("DECK", "SIDEBOARD") var collection_type : int = 0
@onready var deck : Deck = GameManager.player_deck
@export var flow_container : FlowContainer
@export var close_button : Button
func _ready() -> void:
	close_button.pressed.connect(save_deck)
	flow_container.child_order_changed.connect(_on_child_order_changed)
	update_card_count()
	load_deck()

func _on_child_order_changed() -> void:
	update_card_count()

func update_card_count() -> void:
	if not card_count_node:
		return
	var card_count = flow_container.get_child_count()
	if collection_type == 0:
		card_count_node.text = str(card_count) + " / " + str(Deck.MAX_DECK_SIZE)
		if card_count < Deck.MAX_DECK_SIZE:
			card_count_node.add_theme_color_override("font_color", Color(1, 0, 0))
			close_button.disabled = true
		else:
			card_count_node.add_theme_color_override("font_color", Color(1, 1, 1))
			close_button.disabled = false
	else:
		card_count_node.text = str(flow_container.get_child_count())


func save_deck() -> void:
	if collection_type == 0:
		deck.deck = []
	else:
		deck.sideboard = []
	for child in flow_container.get_children():
		if child is CardCollectionSlot:
			var card_slot : CardCollectionSlot = child
			var card_resource : CardResource = card_slot.card_container.card_resource
			if collection_type == 0:
				deck.add_card_to_deck(card_resource)
			else:
				deck.sideboard.append(card_resource)


func load_deck() -> void:
	GameManager.can_play_cards = true
	var collection = deck.deck
	if collection_type == 1:
		collection = deck.sideboard
	for card_resource in collection:
		print('Placing card: ' + card_resource.title)
		place_card_resource(card_resource)


func place_card_resource(card_resource: CardResource) -> void:
	var card: CardContainer = Deck.CARD_SCENE.instantiate()
	card.set_card(card_resource)
	card.collection_view = true
	place_card_instance(card)


func place_card_instance(card: CardContainer) -> void:
	var card_slot: CardCollectionSlot = CardCollectionSlot.new()
	card_slot.set_card_container(card)
	card_slot.card_collection = self
	flow_container.add_child(card_slot)


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if data is Card and not data.is_ancestor_of(self):
		var card_container : CardContainer = data.get_parent()
		var card_slot : CardCollectionSlot = card_container.get_parent()
		reparent_to_collection(card_slot, self)
		return true
	return false


func reparent_to_collection(
	card_slot: CardCollectionSlot,
	collection: CardCollection
	) -> void:
	card_slot.reparent(collection.flow_container)
	card_slot.card_collection = collection


@export var opposing_collection : CardCollection = null
func move_request(card_slot: CardCollectionSlot) -> void:
	reparent_to_collection(card_slot, opposing_collection)

extends Control
class_name CardCollectionSlot

@export var target_width : int = 100
var card_scaler : float = 1.0


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS  # Allow drop events to pass through to parent
	card_scaler = target_width / Card.CARD_SIZE.x
	custom_minimum_size = Card.CARD_SIZE * card_scaler
	card_container.custom_minimum_size = custom_minimum_size
	card_container.size = custom_minimum_size
	card_container.card_visualizer.scale = Vector2(card_scaler, card_scaler)

var card_container : CardContainer = null
func set_card_container(_card_container: CardContainer) -> void:
	card_container = _card_container
	card_container.played.connect(_on_card_played)
	# Also scale the card visualizer
	add_child(card_container)

var card_collection : CardCollection = null
func _on_card_played(_card : CardContainer) -> void:
	card_collection.move_request(self)
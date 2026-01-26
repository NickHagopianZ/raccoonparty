extends Control

static var Cards: Dictionary[String, Card] = {
	"Card 1": preload("res://Assets/CardResources/card_1.tres"),
}

var card: Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Set the card's title and description (using BBCode format).
func set_card(card_name: String):
	card = Cards[card_name]
	$Title.text = card.title
	$Description.text = card.description

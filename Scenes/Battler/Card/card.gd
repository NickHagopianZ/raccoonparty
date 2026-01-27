extends Control
class_name Card

signal played(index: int)

var card_resource: CardResource
var hand_index: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# Set the card's title and description (using BBCode format).
func set_card(new_card: CardResource):
	card_resource = new_card
	$Title.text = card_resource.title
	$Description.text = card_resource.description

func set_index(i: int):
	hand_index = i
	position.x = hand_index * (size.x * 1.2)

func play_card():
	print("Playing card", card_resource, "located at", hand_index)
	played.emit(hand_index)

extends Control
class_name CardContainer

signal played(card: CardContainer)

var card_resource: CardResource
var hand_index: int

@export var description_label : RichTextLabel
@export var title_label : Label
@export var card_visualizer : ColorRect

# Set the card's title and description (using BBCode format).
func set_card(new_card: CardResource):
	card_resource = new_card
	title_label.text = card_resource.title
	description_label.text = card_resource.description


func play_card():
	played.emit(self)


func _ready() -> void:
	card_visualizer.playing_card.connect(play_card)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	card_visualizer.mouse_entered.connect(_on_mouse_entered)
	card_visualizer.mouse_exited.connect(_on_mouse_exited)


const lerp_speed = 5.0
var _initialized := false

var collection_view := false
func _physics_process(delta: float) -> void:
	var target_position : Vector2 = global_position 
	if not collection_view:
		target_position += get_rect().size / 2 - Card.CARD_SIZE / 2
	var target_rotation : float = 0.0

	# Initialize position on first frame
	if not _initialized:
		# card_visualizer.global_position = target_position
		_initialized = true
		return

	var cards_in_hand = get_parent().get_child_count()
	var index = get_index()
	var center = (cards_in_hand - 1) / 2.0
	var distance_from_center = index - center
	target_rotation = distance_from_center * PI / 70.0
	if card_visualizer.hovered and not card_visualizer.held and not collection_view:
		target_position.y -= 30.0
	

	card_visualizer.global_position = lerp(
		card_visualizer.global_position, target_position, delta * lerp_speed)
	card_visualizer.rotation = lerp(
		card_visualizer.rotation, target_rotation, delta * lerp_speed)


func _on_mouse_entered() -> void:
	card_visualizer.hovered = true


func _on_mouse_exited() -> void:
	card_visualizer.hovered = false

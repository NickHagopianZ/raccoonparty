extends Control


@export var edit_deck : Button
@export var flavor_text : RichTextLabel
@export var dialogue_choices_container : VBoxContainer
@export var partner_stats : VBoxContainer
@export var end_interaction_button : Button
@export var reward_display : Control

const goodbye_text_options = [
	"See ya",
	"L8r g8r",
	"Catch you on the flip side!",
	"Stay safe out there!",
	"Until next time!",
	"Peace out!",
	"Hasta la vista, baby!",
	"HAGS!",
	"Until we meet again!",
	"Take care of yourself, and if you can, someone else too."
]
var goodbye_text_index : int = 0

func _ready() -> void:
	visible = false
	end_interaction_button.pressed.connect(GameManager.end_interaction)
	GameManager.starting_interaction.connect(_on_starting_interaction)
	GameManager.ending_interaction.connect(_on_ending_interaction)
	GameManager.starting_battle.connect(_on_starting_battle)
	GameManager.ending_battle.connect(_on_ending_battle)


func _on_starting_battle(_enemy : NPCEntity) -> void:
	visible = false


func _on_ending_battle(_was_victory: bool) -> void:
	# TODO defeat lines?
	visible = true



const default_dialogue_options : Array[String] = [
	"Hey!",
	"Wassup?",
	"Yo yo yo."
]
func generate_npc_dialogue_options(options : Array[String]) -> void:
	# for dialogue_option in options:
	var dialogue_option = options.pick_random()
	var button : Button = Button.new()
	button.text = dialogue_option
	button.pressed.connect(_on_npc_dialogue_option_selected)
	dialogue_choices_container.add_child(button)

	dialogue_choices_container.move_child(
		end_interaction_button,
		-1
	)


func _on_npc_dialogue_option_selected() -> void:
	if interaction_partner:
		GameManager.start_battle(interaction_partner)

var interaction_partner : Entity = null
func _on_starting_interaction(_interaction_partner : Entity) -> void:
	interaction_partner = _interaction_partner
	flavor_text.text = _interaction_partner.flavor_text

	if _interaction_partner is NPCEntity:
		generate_npc_dialogue_options(default_dialogue_options)
		edit_deck.visible = GameManager.player_deck.deck.size() > Deck.MIN_DECK_SIZE
		end_interaction_button.text = goodbye_text_options[goodbye_text_index]
		goodbye_text_index = (goodbye_text_index + 1) % goodbye_text_options.size()
	else:
		setup_interactable_dialogue(_interaction_partner)
		edit_deck.visible = false
		end_interaction_button.text = "Maybe Later"
	visible = true

func setup_interactable_dialogue(interactable_entity : Entity) -> void:
	var interactable : Interactable = interactable_entity as Interactable
	var interactable_resources : Array[InteractableResource] = interactable.dialogue_options
	for interactable_resource in interactable_resources:
		var button : Button = Button.new()
		button.text = interactable_resource.dialogue
		button.pressed.connect(_on_interactable_dialogue_option_selected.bind(interactable_resource))
		dialogue_choices_container.add_child(button)

	dialogue_choices_container.move_child(
		end_interaction_button,
		-1
	)

func _on_interactable_dialogue_option_selected(interactable_resource : InteractableResource) -> void:
	interaction_partner.disable_interaction()
	# Give rewards
	for card_resource : CardResource in interactable_resource.reward_cards:
		GameManager.player_deck.add_card_to_deck(card_resource)

	for card_resource : CardResource in interactable_resource.rumor_cards:
		print("Adding rumor card: " + card_resource.title)
		GameManager.player_deck.add_card_to_rumor_deck(card_resource, card_resource.rumor_targets)

	# Apply penalties
	for card_resource : CardResource in interactable_resource.penalty_cards:
		GameManager.player_deck.add_card_to_penalty_deck(card_resource)
	var all_cards = interactable_resource.reward_cards + interactable_resource.penalty_cards + interactable_resource.rumor_cards
	reward_display.display_cards(all_cards)

func _on_ending_interaction() -> void:
	visible = false
	for child in dialogue_choices_container.get_children():
		if child == end_interaction_button:
			continue
		child.queue_free()
	interaction_partner = null

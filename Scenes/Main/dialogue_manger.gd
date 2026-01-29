extends Control


@export var edit_deck : Button
@export var flavor_text : RichTextLabel
@export var dialogue_choices_container : VBoxContainer
@export var partner_stats : VBoxContainer
@export var end_interaction_button : Button

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


func _on_ending_battle() -> void:
	# TODO defeat lines?
	visible = true



const default_dialogue_options : Array[String] = [
	"Hey!",
	"Wassup?",
	"Yo yo yo."
]
func generate_npc_dialogue_options(options : Array[String]) -> void:
	for dialogue_option in options:
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
	if _interaction_partner is NPCEntity:
		generate_npc_dialogue_options(default_dialogue_options)
		edit_deck.visible = true
		end_interaction_button.text = goodbye_text_options[goodbye_text_index]
		goodbye_text_index = (goodbye_text_index + 1) % goodbye_text_options.size()
	else:
		edit_deck.visible = false
		end_interaction_button.text = "Maybe Later"
	visible = true


func _on_ending_interaction() -> void:
	visible = false
	for child in dialogue_choices_container.get_children():
		if child == end_interaction_button:
			continue
		child.queue_free()
	interaction_partner = null

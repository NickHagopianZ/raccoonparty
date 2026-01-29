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


func _on_starting_interaction(_interaction_partner : Entity) -> void:
	if _interaction_partner is NPCEntity:
		edit_deck.visible = true
		end_interaction_button.text = goodbye_text_options[goodbye_text_index]
		goodbye_text_index = (goodbye_text_index + 1) % goodbye_text_options.size()
	else:
		edit_deck.visible = false
		end_interaction_button.text = "Maybe Later"
	visible = true


func _on_ending_interaction() -> void:
	visible = false

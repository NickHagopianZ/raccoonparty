extends Node


signal starting_battle(enemy : NPCEntity)
signal ending_battle
signal starting_interaction(partner : Node3D)
signal ending_interaction

var player_node : PlayerEntity
# Kevin : player deck can be stored here as a globally accessible variable
var player_deck : Deck = Deck.new()

func start_battle(enemy : NPCEntity) -> void:
	player_deck.reset_deck()
	starting_battle.emit(enemy)


func end_battle() -> void:
	ending_battle.emit()


func start_npc_interaction(partner : Node3D) -> void:
	starting_interaction.emit(partner)


func end_npc_interaction() -> void:
	ending_interaction.emit()

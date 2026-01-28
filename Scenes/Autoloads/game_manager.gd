extends Node


signal starting_battle(enemy : NPCEntity)
signal ending_battle

var player_node : PlayerEntity
# Kevin : player deck can be stored here as a globally accessible variable

func start_battle(enemy : NPCEntity) -> void:
	starting_battle.emit(enemy)


func end_battle() -> void:
	ending_battle.emit()


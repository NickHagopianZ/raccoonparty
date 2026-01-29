extends Node


signal starting_battle(enemy : NPCEntity)
signal ending_battle
signal starting_interaction(interaction_partner : Entity)
signal ending_interaction
signal starting_game
signal quitting_to_title
signal pausing
signal unpausing

var player_node : PlayerEntity
# Kevin : player deck can be stored here as a globally accessible variable
var player_deck : Deck = Deck.new()
var game_started : bool = false

func start_battle(enemy : NPCEntity) -> void:
	player_deck.reset_deck()
	starting_battle.emit(enemy)


func end_battle() -> void:
	ending_battle.emit()


func start_interaction(interaction_partner : Entity) -> void:
	starting_interaction.emit(interaction_partner)


func end_interaction() -> void:
	ending_interaction.emit()


func start_game() -> void:
	starting_game.emit()
	game_started = true


func quit_to_title() -> void:
	quitting_to_title.emit()
	game_started = false

func quit_to_desktop() -> void:
	get_tree().quit()


func pause() -> void:
	if game_started:
		pausing.emit()
		get_tree().paused = true


func unpause() -> void:
	if game_started:
		unpausing.emit()
		get_tree().paused = false


func full_screen_toggle() -> void:
	var current_mode = DisplayServer.window_get_mode()
	if current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func set_volume(volume: float, bus_name: String) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	if bus_index == -1:
		print("Error: Bus name not found - " + bus_name)
		return
	AudioServer.set_bus_volume_linear(bus_index, volume / 100.0)

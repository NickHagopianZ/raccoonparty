extends Node


signal starting_battle(enemy : NPCEntity)
signal ending_battle(was_victory: bool)
signal starting_interaction(interaction_partner : Entity)
signal ending_interaction
signal starting_game
signal quitting_to_title
signal pausing
signal unpausing
signal play_sfx(which: SFX)
signal continue_music_from(duration: float)
signal all_food_found
var interaction_partner : Entity = null

var player_node : PlayerEntity
# Kevin : player deck can be stored here as a globally accessible variable
var player_deck : Deck = Deck.new()
var game_started : bool = false
var round_timer_running: bool = true
var can_play_cards: bool = true
var first_battle: bool = true
var total_food_available: int = 0
var food_counter: int = 0

enum SFX {
	Interact,
	Descent,
}


func found_all_food():
	return food_counter >= total_food_available


func start_battle(enemy : NPCEntity) -> void:
	player_deck.reset_deck(enemy.name)
	starting_battle.emit(enemy)


func start_interaction(_interaction_partner : Entity) -> void:
	interaction_partner = _interaction_partner
	starting_interaction.emit(_interaction_partner)


func end_interaction() -> void:
	ending_interaction.emit()
	interaction_partner = null

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
		get_tree().paused = true
		pausing.emit()


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


# cursor operations
var cursor_hotspot = Vector2(5, 6)
var dragging : bool = false
var cursors = {
	Input.CURSOR_ARROW: load("res://Assets/UI/raccoon_hand.png"),
	Input.CURSOR_DRAG: load("res://Assets/UI/raccoon_hand_grab.png"),
	Input.CURSOR_CAN_DROP: load("res://Assets/UI/raccoon_hand_grab.png"),
	Input.CURSOR_FORBIDDEN: load("res://Assets/UI/raccoon_hand_grab.png"),
	"pointing_hand": load("res://Assets/UI/raccoon_hand_click.png")
}

func _ready() -> void:
	set_cursor(Input.CURSOR_ARROW)
	set_cursor(Input.CURSOR_DRAG)
	set_cursor(Input.CURSOR_CAN_DROP)
	set_cursor(Input.CURSOR_FORBIDDEN)


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("left_click"):
		Input.set_custom_mouse_cursor(
			cursors["pointing_hand"],
			Input.CURSOR_ARROW,
			cursor_hotspot
		)
	else:
		set_cursor(Input.CURSOR_ARROW)

func set_cursor(cursor_type: int) -> void:
	if cursor_type in cursors:
		Input.set_custom_mouse_cursor(
			cursors[cursor_type],
			cursor_type,
			cursor_hotspot
		)

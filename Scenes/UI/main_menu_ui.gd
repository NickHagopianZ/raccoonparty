extends Control


func _ready() -> void:
	visible = true
	GameManager.quitting_to_title.connect(_on_quit_to_title)
	GameManager.starting_game.connect(_on_start_game)


func _on_quit_to_title() -> void:
	visible = true
	$Music.play()


func _on_start_game() -> void:
	visible = false
	GameManager.continue_music_from.emit($Music.get_playback_position())
	$Music.stop()

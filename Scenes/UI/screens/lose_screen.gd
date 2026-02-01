extends TextureRect

@export var try_again_button : Button
func _ready() -> void:
	visible = false
	GameManager.ending_battle.connect(_on_ending_battle)
	try_again_button.pressed.connect(_on_try_again_button_pressed)

func _on_ending_battle(was_victory: bool) -> void:
	print('hereeee')
	if not was_victory:
		visible = true

func _on_try_again_button_pressed() -> void:
	visible = false
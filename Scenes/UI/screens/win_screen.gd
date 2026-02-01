extends TextureRect

@export var return_to_menu_button : Button
func _ready() -> void:
	visible = false
	GameManager.all_food_found.connect(show_screen)
	return_to_menu_button.pressed.connect(_on_return_to_menu_button_pressed)

func show_screen() -> void:
	visible = true

func _on_return_to_menu_button_pressed() -> void:
	visible = false
	GameManager.quit_to_title()
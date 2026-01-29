extends Control


@export var menu_container : Control
func _ready() -> void:
	visible = false
	GameManager.pausing.connect(_on_paused)
	GameManager.unpausing.connect(_on_unpaused)
	GameManager.quitting_to_title.connect(_on_quit_to_title)


func _on_quit_to_title() -> void:
	GameManager.unpause()

func _on_paused() -> void:
	visible = true

func _on_unpaused() -> void:
	visible = false
	if menu_container.get_child_count() == 2:
		menu_container.get_child(-1).queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			GameManager.unpause()
		else:
			GameManager.pause()

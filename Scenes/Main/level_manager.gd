# loads in levels and manages level transitions
extends Node3D


@export var initial_level_scene : PackedScene
func _ready() -> void:
	GameManager.starting_game.connect(load_scene)
	GameManager.quitting_to_title.connect(clear_scene)

func clear_scene() -> void:
	# remove all existing children (current level)
	for child in get_children():
		child.queue_free()

func load_scene(new_scene : PackedScene = initial_level_scene) -> void:
	clear_scene()
	
	# instantiate and add the new level scene
	var level_instance = new_scene.instantiate()
	add_child(level_instance)

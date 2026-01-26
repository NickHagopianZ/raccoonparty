# loads in levels and manages level transitions
extends Node2D


@export var initial_level_scene : PackedScene
func _ready() -> void:
	if initial_level_scene:
		load_scene(initial_level_scene)


func load_scene(new_scene : PackedScene) -> void:
	# remove all existing children (current level)
	for child in get_children():
		child.queue_free()
	
	# instantiate and add the new level scene
	var level_instance = new_scene.instantiate()
	add_child(level_instance)
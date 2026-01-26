extends Area2D
class_name RoomHandler

@export var show_sprites : Array[Sprite2D] = []
@export var hide_sprites : Array[Sprite2D] = []


func _ready() -> void:
	collision_layer = 0
	collision_mask = 4

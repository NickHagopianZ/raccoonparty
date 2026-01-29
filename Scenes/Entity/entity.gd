extends CharacterBody3D
class_name Entity

@export var sprite_frames : SpriteFrames
@export var sprite : AnimatedSprite3D
@export_multiline var flavor_dialogue : String

func _ready() -> void:
	sprite.sprite_frames = sprite_frames
	sprite.play("Idle")

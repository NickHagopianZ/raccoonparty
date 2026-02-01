extends CharacterBody3D
class_name Entity

@export var sprite_frames : SpriteFrames
@export var sprite : AnimatedSprite3D
@export var entity_name : String = ""
@export_multiline var flavor_text : String

func _ready() -> void:
	sprite.sprite_frames = sprite_frames
	play_animation("Idle")


func play_animation(requested_animation: String) -> void:
	if sprite_frames.has_animation(requested_animation):
		if sprite.animation != requested_animation:
			sprite.play(requested_animation)
	else:
		if sprite.animation.begins_with(requested_animation):
			return

		var animation_names = sprite_frames.get_animation_names()
		var possible_animations = []
		for animation_name in animation_names:
			if animation_name.begins_with(requested_animation):
				possible_animations.append(animation_name)
		
		sprite.play(possible_animations.pick_random())
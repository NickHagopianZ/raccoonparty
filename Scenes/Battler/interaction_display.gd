extends Node2D

@export var player_sprite : AnimatedSprite2D
@export var opposing_sprite : AnimatedSprite2D
func _ready() -> void:
	visible = false
	GameManager.starting_interaction.connect(_on_starting_interaction)
	GameManager.ending_interaction.connect(_on_ending_interaction)

func _on_starting_interaction(interactable : Entity) -> void:
	visible = true
	if interactable is NPCEntity:
		opposing_sprite.scale = Vector2.ONE * 0.5
	else:
		opposing_sprite.scale = Vector2.ONE * 4.0
		opposing_sprite.global_position.y = player_sprite.global_position.y + 20.0
	opposing_sprite.sprite_frames = interactable.sprite_frames

	player_sprite.sprite_frames = GameManager.player_node.sprite_frames
	opposing_sprite.play("Interact")
	player_sprite.play("Interact")
	var viewport_size : Vector2 = get_viewport_rect().size
	opposing_sprite.global_position.x = viewport_size.x - player_sprite.global_position.x
	opposing_sprite.flip_h = true

func _on_ending_interaction() -> void:
	visible = false

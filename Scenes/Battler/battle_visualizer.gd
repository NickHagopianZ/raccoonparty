extends Node2D

@export var player_sprite : AnimatedSprite2D
@export var enemy_sprite : AnimatedSprite2D
func _ready() -> void:
	visible = false
	GameManager.starting_battle.connect(_on_starting_battle)
	GameManager.ending_battle.connect(_on_ending_battle)

func _on_starting_battle(enemy : NPCEntity) -> void:
	visible = true
	enemy_sprite.sprite_frames = enemy.sprite.sprite_frames
	player_sprite.sprite_frames = GameManager.player_node.sprite.sprite_frames
	enemy_sprite.play("Battle")
	player_sprite.play("Battle")
	var viewport_size : Vector2 = get_viewport_rect().size
	enemy_sprite.global_position.x = viewport_size.x - player_sprite.global_position.x
	enemy_sprite.flip_h = true

func _on_ending_battle() -> void:
	visible = false

extends Control

@export var card_sprite : ColorRect

func _ready() -> void:
	card_sprite.top_level = true


func _physics_process(_delta: float) -> void:
	card_sprite.global_position = global_position
	var cards_in_hand = get_parent().get_parent().get_child_count()
	var index = get_index()
	var center = (cards_in_hand + 1) / 2.0
	var distance_from_center = index - center
	card_sprite.rotation = distance_from_center * PI / 70.0
	card_sprite.global_position.y += abs(distance_from_center) * 10.0

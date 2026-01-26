extends CharacterBody2D
class_name BaseEntity

@export var speed : float = 30000.0
const y_speed_ratio : float = 0.66
var forward_direction : float = 1.0

@export var body_sprite : Node2D
# when we get a sprite replace the above line with this one
# @export var body_sprite : Sprite2D


func perform_move(input_vector: Vector2, delta: float) -> void:
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	velocity = speed * delta * Vector2(input_vector.x, input_vector.y * y_speed_ratio)
	move_and_slide()
	if input_vector.x > 0 and forward_direction < 0:
		forward_direction = 1.0
	elif input_vector.x < 0 and forward_direction > 0:
		forward_direction = -1.0

	body_sprite.scale.x = lerp(body_sprite.scale.x, forward_direction, delta * 10.0)

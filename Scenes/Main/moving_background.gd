extends TextureRect
class_name MovingBackground

@export var mouse_effect_speed : Vector2 = Vector2(0.3, 0.1)
@export var lerp_speed : float = 4.0


var target_adjustment = Vector2.ZERO
var centered_position = Vector2.ZERO
var max_adjustment = Vector2.ZERO

func _ready() -> void:
	var texture_size
	if texture != null:
		texture_size = texture.get_size()
	else:
		texture_size = Vector2(2304, 1296)
	var viewport_size = get_viewport_rect().size
	var viewport_position = get_viewport_rect().position

	max_adjustment = Vector2(
		(viewport_size.x / 5.0) * mouse_effect_speed.x,
		(viewport_size.y / 5.0) * mouse_effect_speed.y
		)

	scale = Vector2.ONE * max(
		(viewport_size.x + max_adjustment.x * 2.0) / texture_size.x,
		(viewport_size.y + max_adjustment.y * 2.0) / texture_size.y
		)

	var new_size = size * scale
	centered_position = viewport_position - ((new_size - viewport_size) / 2.0)
	position = centered_position


func _physics_process(delta: float) -> void:
	target_adjustment = get_target_adjustment(get_global_mouse_position())
	position = position.lerp(centered_position - target_adjustment, lerp_speed * delta / 3.0)


func get_target_adjustment(mouse_pos: Vector2) -> Vector2:
	var viewport_size = get_viewport_rect().size
	var viewport_position = get_viewport_rect().position

	var center_pos = viewport_position + (viewport_size / 2)
	var adjustment = Vector2(
		(center_pos.x - mouse_pos.x) * mouse_effect_speed.x,
		(center_pos.y - mouse_pos.y) * mouse_effect_speed.y
		)
	adjustment.x = clamp(adjustment.x, -max_adjustment.x, max_adjustment.x)
	adjustment.y = clamp(adjustment.y, -max_adjustment.y, max_adjustment.y)
	return adjustment

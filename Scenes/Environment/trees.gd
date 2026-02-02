extends Sprite3D



func _ready() -> void:
	modulate = Color.WHITE * randf_range(0.7, 1.0)
	modulate.a = 1.0
	var scale_rand : float = randf_range(0.7, 1.3)
	scale = Vector3.ONE * scale_rand
	position.y = 5 * scale_rand
	flip_h = randi() % 2 == 0
	
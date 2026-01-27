extends CharacterBody3D
class_name BaseEntity

@export var speed : float = 10.0
var forward_direction : float = 1.0

@export var body_3d : Sprite3D
@export var sprite_parent : Node3D


func _physics_process(delta: float) -> void:
	perform_move(Vector3.ZERO, delta)
	billboard_sprite()


func billboard_sprite() -> void:
	var _camera = get_viewport().get_camera_3d()
	# var current_rotation : Vector3 = sprite_parent.rotation
	sprite_parent.look_at(_camera.global_position)
	# sprite_parent.rotation.x = current_rotation.x
	# sprite_parent.rotation.y = current_rotation.y
	# sprite_parent.rotation.z = current_rotation.zd


func perform_move(input_vector: Vector3, delta: float) -> void:
	var gravity : Vector3 = Vector3.DOWN * 9.81
	velocity = speed * input_vector
	velocity += gravity
	move_and_slide()
	if input_vector.x > 0.1 and forward_direction == 0.0:
		forward_direction = 1.0
	elif input_vector.x < -0.1 and forward_direction > 0.0:
		forward_direction = 0.0
	var target_rotation_y : float = forward_direction * PI
	body_3d.rotation.y = lerp(body_3d.rotation.y, target_rotation_y, delta * 5.0)

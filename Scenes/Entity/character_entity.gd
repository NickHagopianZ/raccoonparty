extends Entity
class_name CharacterEntity

@export var speed : float = 10.0
@export var sprite_parent : Node3D
@export var navigation_agent : NavigationAgent3D
var look_target : Node3D


func _ready() -> void:
	sprite.sprite_frames = sprite_frames
	sprite.play("Idle")

func billboard_sprite() -> void:
	var _camera = get_viewport().get_camera_3d()
	# var current_rotation : Vector3 = sprite_parent.rotation
	sprite_parent.look_at(_camera.global_position)
	# sprite_parent.rotation.x = current_rotation.x
	# sprite_parent.rotation.y = current_rotation.y
	# sprite_parent.rotation.z = current_rotation.z

var target_rotation : float = 0.0
func perform_move(input_vector: Vector3, delta: float) -> void:
	var gravity : Vector3 = Vector3.DOWN * 9.81
	velocity = speed * input_vector
	velocity += gravity
	move_and_slide()

	var look_direction : Vector3 = velocity
	if look_target:
		look_direction = (look_target.global_position - global_position).normalized()
	look_direction.y = 0.0
	look_direction = look_direction.normalized()

	var camera = get_viewport().get_camera_3d()
	var look_dot : float = look_direction.dot(camera.transform.basis.x)

	if look_dot > 0.1:
		target_rotation = PI
	elif look_dot < -0.1:
		target_rotation = 0.0
	else:
		target_rotation = roundi(target_rotation)

	sprite.rotation.y = lerp(sprite.rotation.y, target_rotation, delta * 5.0)


func perform_navigation_move(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		perform_move(Vector3.ZERO, delta)
	else:
		var next_path_position : Vector3 = navigation_agent.get_next_path_position()
		var direction : Vector3 = (next_path_position - global_position).normalized()
		perform_move(direction, delta)


func move_to_target(target_position : Vector3) -> void:
	navigation_agent.target_position = target_position

extends CharacterBody2D


@export var camera : Camera2D
var camera_target : Node2D
const flat_speed : float = 1000.0
@export var y_speed : float = 10.0
@export var x_speed : float = 10.0


func _ready() -> void:
	# set the camera to top level so it doesn't get affected by parent transforms
	camera.top_level = true
	camera_target = self

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = flat_speed * delta * Vector2(input_vector.x * x_speed, input_vector.y * y_speed)
	move_and_slide()

	if camera and camera_target:
		camera.global_position = camera_target.global_position

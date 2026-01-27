extends BaseEntity
class_name PlayerCharacter

@export var camera : Camera3D
var camera_target : Node3D
@export var camera_follow_node : Node3D
@export var camera_ghost : Node3D

@export var interaction_area : Area3D
var interactable_bodies : Array = []
var interaction_area_initial_position : Vector3
var searching_for_interactables : bool = true
@export var interact_sprite : Sprite3D

func _ready() -> void:
	# set the camera to top level so it doesn't get affected by parent transforms
	camera_target = camera_follow_node
	interaction_area.body_entered.connect(_on_interaction_area_body_entered)
	interaction_area.body_exited.connect(_on_interaction_area_body_exited)
	interaction_area_initial_position = interaction_area.position
	last_input_vector = interaction_area_initial_position.normalized()
	interact_sprite.visible = false
	interact_sprite.top_level = true

func _physics_process(delta: float) -> void:
	move_player(delta)
	move_camera(delta)
	check_interactions(delta)


var last_input_vector : Vector3 = Vector3.ZERO
func move_player(delta: float) -> void:
	var input_vector : Vector3 = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	perform_move(input_vector, delta)
	billboard_sprite()

	if input_vector.x != 0.0:
		last_input_vector = input_vector.normalized()

	interaction_area.position.x = lerp(
		interaction_area.position.x, 
		interaction_area_initial_position.x * last_input_vector.x, 
		delta * 10.0)
	camera_ghost.global_position = lerp(
		camera_ghost.global_position, 
		global_position + last_input_vector * 3.0,
		delta
		)


func move_camera(_delta: float) -> void:
	if camera_target:
		camera.global_position = camera_target.global_position


func check_interactions(delta : float) -> void:
	if not searching_for_interactables or interactable_bodies.size() == 0:
		interact_sprite.visible = false
		return
	if interactable_bodies.size() > 0:
		var closest_body : Node = interactable_bodies[0]
		var closest_distance : float = global_position.distance_to(closest_body.global_position)
		for body in interactable_bodies:
			var distance : float = global_position.distance_to(body.global_position)
			if distance < closest_distance:
				closest_body = body
				closest_distance = distance
		var body : Node = closest_body
		if interact_sprite.visible == false:
			interact_sprite.visible = true
			interact_sprite.global_position = body.global_position
		else:
			interact_sprite.global_position = lerp(
				interact_sprite.global_position, 
				body.global_position, 
				10.0 * delta)
		
		if body.has_method("focus"):
			body.focus(self)
		if Input.is_action_just_pressed("interact") and body.has_method("interact"):
			body.interact(self)


func _on_interaction_area_body_entered(body: Node) -> void:
	if body not in interactable_bodies:
		interactable_bodies.append(body)

func _on_interaction_area_body_exited(body: Node) -> void:
	if body in interactable_bodies:
		interactable_bodies.erase(body)

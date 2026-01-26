extends BaseEntity
class_name PlayerCharacter

@export var camera : Camera2D
var camera_target : Node2D

@export var interaction_area : Area2D
var interactable_bodies : Array = []
var interaction_area_initial_position : Vector2
var searching_for_interactables : bool = true
@export var interact_sprite : Sprite2D

func _ready() -> void:
	# set the camera to top level so it doesn't get affected by parent transforms
	camera.top_level = true
	camera_target = self
	interaction_area.body_entered.connect(_on_interaction_area_body_entered)
	interaction_area.body_exited.connect(_on_interaction_area_body_exited)
	interaction_area_initial_position = interaction_area.position
	interact_sprite.visible = false
	interact_sprite.top_level = true

func _physics_process(delta: float) -> void:
	move_player(delta)
	move_camera(delta)
	check_interactions(delta)


func move_player(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	perform_move(input_vector, delta)

	interaction_area.position.x = lerp(
		interaction_area.position.x, 
		interaction_area_initial_position.x * forward_direction, 
		delta * 10.0)

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
			print("Moving interact sprite")
			interact_sprite.global_position = lerp(
				interact_sprite.global_position, 
				body.global_position, 
				10.0 * delta)
		
		if body.has_method("focus"):
			body.focus(self)
		if Input.is_action_just_pressed("interact") and body.has_method("interact"):
			body.interact(self)


func _on_interaction_area_body_entered(body: Node) -> void:
	print("Body entered interaction area: ", body.name)
	if body not in interactable_bodies:
		interactable_bodies.append(body)

func _on_interaction_area_body_exited(body: Node) -> void:
	print("Body exited interaction area: ", body.name)
	if body in interactable_bodies:
		interactable_bodies.erase(body)

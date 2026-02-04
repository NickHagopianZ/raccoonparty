extends CharacterEntity
class_name NPCEntity

@export_range(0, 4) var difficulty: int
@export var difficulty_node: Sprite3D
@export var name_label: Label3D
@export var rewards : InteractableResource
@export_multiline var defeat_dialogue :String
@export var init_flip : bool = false
@export var actions: Array[NPCAction] = []
@export var archetype : String = ""

func _ready():
	name_label.visible = false

	GameManager.ending_battle.connect(_on_ending_battle)
	update_sprites()
	if not rewards:
		rewards = InteractableResource.new()
	rewards.fill_rewards_if_empty(1 + randi() % 2, difficulty)
	actions = AllNPCActions.get_named_collection(entity_name)
	if archetype != "" and actions.size() == 0:
		actions = AllNPCActions.get_archetype_collection(archetype, difficulty)
	elif actions.size() == 0:
		# default action
		actions = AllNPCActions.get_random_actions(5, difficulty)

func choose_battler_action():
	return actions.pick_random()


var look_duration : float = 0.0
func _physics_process(delta: float) -> void:
	bounce(delta)
	perform_navigation_move(delta)
	billboard_sprite()

	if look_duration > 0.0:
		look_duration -= delta
		if look_duration <= 0.0:
			look_target = null
			name_label.visible = false


var scale_bounce_direction : int = 1
var rotation_bounce_direction : int = 1
const MAX_SCALE_BOUNCE_VALUE : float = 0.15
const MAX_ROTATION_BOUNCE_VALUE : float = 0.1
var total_scale_bounce : float = randf() * MAX_SCALE_BOUNCE_VALUE
var total_rotation_bounce : float = randf_range(
	-MAX_ROTATION_BOUNCE_VALUE,
	MAX_ROTATION_BOUNCE_VALUE
)
var scale_bounce_speed : float = randf_range(0.05, 0.1)
var rotation_bounce_speed : float = randf_range(0.05, 0.2)
func bounce(delta: float) -> void:
	var scale_bounce_amount : float = delta * scale_bounce_speed
	var rotation_bounce_amount : float = delta * rotation_bounce_speed

	if abs(total_scale_bounce) >= MAX_SCALE_BOUNCE_VALUE or total_scale_bounce < 0.0:
		scale_bounce_direction *= -1
	if abs(total_rotation_bounce) >= MAX_ROTATION_BOUNCE_VALUE or total_rotation_bounce < -MAX_ROTATION_BOUNCE_VALUE:
		rotation_bounce_direction *= -1

	scale_bounce_amount *= scale_bounce_direction
	rotation_bounce_amount *= rotation_bounce_direction

	total_scale_bounce += scale_bounce_amount
	total_rotation_bounce += rotation_bounce_amount

	sprite.scale.y = 1.0 + total_scale_bounce
	sprite.rotation.z = total_rotation_bounce


var is_defeated : bool = false
func _on_ending_battle(_was_victory: bool) -> void:
	if GameManager.interaction_partner == self and _was_victory:
		defeated()

func defeated() -> void:
	is_defeated = true
	name_label.visible = false

	set_collision_layer_value(2, false) # disable interaction layer


func focus(by_entity: CharacterEntity) -> void:
	look_target = by_entity
	look_duration = 0.5
	name_label.visible = true


func interact(by_entity: CharacterEntity, move_player : bool = false) -> void:
	if move_player:
		# NPC interacted with by an entity (e.g., player)
		var camera = get_viewport().get_camera_3d()

		var meet_positions : Array[Vector3] = [
			by_entity.global_position + camera.transform.basis.x * 3.5,
			by_entity.global_position - camera.transform.basis.x * 3.5
		]
		# validate positions
		var shortest_path : float = 6000.0

		var shortest_position : Vector3 = global_position
		for pos in meet_positions:
			by_entity.move_to_target(pos)
			# get path length
			var path_length = navigation_agent.get_path_length()
			if path_length < shortest_path:
				shortest_path = path_length
				shortest_position = pos

		by_entity.move_to_target(shortest_position)

	GameManager.start_interaction(self)


const body_adjustment : float = 0.2
func update_sprites() -> void:
	sprite.flip_h = init_flip

	# every body is beautiful
	sprite.scale.y = 1.0 + randf_range(-body_adjustment, body_adjustment)
	sprite.scale.x = 1.2 + randf_range(-body_adjustment, body_adjustment)
	sprite.scale.z = 1.2 + randf_range(-body_adjustment, body_adjustment)
	if sprite_frames == null: # set generic background color
		sprite_frames = sprite.sprite_frames
		play_animation("Idle")
		sprite.modulate = Color(
			randf_range(0.3, 0.6),
			randf_range(0.3, 0.6),
			randf_range(0.6, 1.0)
			)
		set_collision_layer_value(2, false) # disable interaction layer
	else:
		sprite.sprite_frames = sprite_frames
		play_animation("Idle")
		GameManager.total_food_available += 1
		if difficulty_node and difficulty > 0:
			difficulty_node.frame = difficulty - 1
		name_label.text = entity_name

extends CharacterEntity
class_name NPCEntity

var actions: Array[NpcAction] = []

class NpcAction:
	var actions: Array[BattleScores.Action]
	var message: String

	func _init(action_strs: Array[String], p_message: String):
		actions = []
		for action_str in action_strs:
			actions.append(BattleScores.Action.new(action_str))
		message = p_message


func _ready():
	actions.append(NpcAction.new(["-1 Sus"], "You look funny"))
	actions.append(NpcAction.new(["D1 Fear", "D1 Vibes"], "Huh? Sorry. I was looking at my phone."))


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



func focus(by_entity: CharacterEntity) -> void:
	look_target = by_entity
	look_duration = 0.5

func interact(by_entity: CharacterEntity) -> void:
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

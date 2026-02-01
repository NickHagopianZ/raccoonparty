extends CharacterEntity
class_name NPCEntity

@export var archetype : Archetype
enum Archetype {
	Rando,
	TutorialBouncer,
	Bully,
}

@export var rewards : Array[CardResource] = []
var actions: Array[NpcAction] = []

class NpcAction:
	var actions: Array[BattleScores]
	var message: String

	func _init(p_message: String, action_strs: Array[String]):
		actions = []
		for action_str in action_strs:
			actions.append(BattleScores.new(action_str))
		message = p_message


func _ready():
	# Targets Vibes
	actions.append(NpcAction.new("I don't really know anyone here...", ["-1 Vibes"]))
	actions.append(NpcAction.new("Honestly I'm more into, like, taller guys", ["-1 Vibes"]))
	actions.append(NpcAction.new("I moved here to be closer to family, but I don't like my family.", ["-1 Vibes"]))

	# Targets Sus
	actions.append(NpcAction.new("Do you always dress like that?", ["-1 Sus"]))
	actions.append(NpcAction.new("Your cologne is... intereseting. Very earthy. Compost-like.", ["D1 Vibes", "-1 Sus"]))
	actions.append(NpcAction.new("Did I see you crawling out of a dumpster just before the party?", ["-1 Sus"]))

	# Targets Fear
	actions.append(NpcAction.new("Your mask is SOOOO cute!", ["-1 Fear", "D1 Sus"]))
	actions.append(NpcAction.new("Yeah, I can basically bench around 450 now", ["-1 Fear", "D1 Vibes"]))

	# Defense
	actions.append(NpcAction.new("Huh? Sorry. I was looking at my phone.", ["D1 Vibes", "D1 Fear"]))
	actions.append(NpcAction.new("I've been getting more into bird watching recently", ["D1 Fear", "D1 Sus"]))
	actions.append(NpcAction.new("So, uh, what do you do for work?", ["D1 Vibes"]))
	actions.append(NpcAction.new("What kind of music do you listen to?", ["D1 Sus", "D1 Fear"]))

	# Misc
	actions.append(NpcAction.new("Sorry! I thought you were someone's pet dog!", ["+1 Vibes", "-1 Fear", "-1 Sus"]))

	# Filter down to 5 actions randomly
	while len(actions) > 5:
		actions.pop_at(randi() % len(actions))

	if archetype == Archetype.TutorialBouncer:
		actions = [
			NpcAction.new("Who do you know?", ["-5 Sus"]),
			NpcAction.new("Is there anyone who can vouch for you?", ["-5 Sus"]),
		]

	GameManager.ending_battle.connect(_on_ending_battle)
	update_sprites()

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


var is_defeated : bool = false
func _on_ending_battle(_was_victory: bool) -> void:
	if GameManager.interaction_partner == self and _was_victory:
		defeated()

func defeated() -> void:
	is_defeated = true
	set_collision_layer_value(2, false) # disable interaction layer


func focus(by_entity: CharacterEntity) -> void:
	look_target = by_entity
	look_duration = 0.5


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
	# every body is beautiful
	scale.y = 1.0 + randf_range(-body_adjustment, body_adjustment)
	scale.x = 1.2 + randf_range(-body_adjustment, body_adjustment)
	scale.z = 1.2 + randf_range(-body_adjustment, body_adjustment)
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

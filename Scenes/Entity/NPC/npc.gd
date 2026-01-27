extends BaseEntity

@export var navigation_agent : NavigationAgent3D


func move_to_target(target_position : Vector3) -> void:
	navigation_agent.target_position = target_position


func _physics_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		perform_move(Vector3.ZERO, delta)
	else:
		var next_path_position : Vector3 = navigation_agent.get_next_path_position()
		var direction : Vector3 = (next_path_position - global_position).normalized()
		perform_move(direction, delta)
	billboard_sprite()


func focus(by_entity: Node) -> void:
	move_to_target(by_entity.global_position)

func interact(by_entity: Node) -> void:
	# NPC interacted with by an entity (e.g., player)
	pass

extends BaseEntity
class_name NPCEntity


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
	look_target = null # reset look target each frame


func focus(by_entity: Node) -> void:
	look_target = by_entity

func interact(by_entity: Node) -> void:
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
		move_to_target(pos)
		# get path length
		var path_length = navigation_agent.get_path_length()
		if path_length < shortest_path:
			shortest_path = path_length
			shortest_position = pos
			
	move_to_target(shortest_position)
	GameManager.start_battle(self)

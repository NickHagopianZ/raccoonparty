extends Area3D


@export var bouncer : NPCEntity
@export var bounce_point : Node3D
func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node) -> void:
	print("Bouncer wall triggered by: %s" % body.name)
	if bouncer.is_defeated:
		collision_mask = 0
		collision_layer = 0
		return # already defeated
	if body is PlayerEntity:
		body.move_to_target(bounce_point.global_position)
		bouncer.interact(body)

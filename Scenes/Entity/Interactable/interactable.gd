extends Entity
class_name Interactable

@export var interaction_point : Vector3 = Vector3(3.0, 0.0, 0.0)
@export var dialogue_options : Array[InteractableResource] = []

func _ready():
	GameManager.total_food_available += 1

func disable_interaction() -> void:
	set_collision_layer_value(2, false) # disable interaction layer

func interact(by_entity: CharacterEntity) -> void:
	# NPC interacted with by an entity (e.g., player)
	GameManager.start_interaction(self)
	by_entity.move_to_target(global_position + interaction_point)

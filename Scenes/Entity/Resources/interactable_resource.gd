extends Resource
class_name InteractableResource

@export_multiline var dialogue : String = ""
@export var reward_cards : Array[CardResource] = []
@export var rumor_cards : Array[CardResource] = []
@export var penalty_cards : Array[CardResource] = []

func fill_rewards_if_empty(num_actions : int , difficulty : int) -> void:
	if reward_cards.size() == 0:
		reward_cards = AllPossibleCards.random_reward(num_actions, difficulty)
extends Resource
class_name NPCAction

@export var actions: Array[BattleScores]
@export var message: String

func _init(p_message: String = "", battle_actions : Array = []) -> void:
	actions = []
	for battle_action in battle_actions:
		actions.append(BattleScores.new(battle_action[0], battle_action[1], battle_action[2]))
	message = p_message

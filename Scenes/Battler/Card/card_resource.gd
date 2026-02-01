extends Resource
class_name CardResource

@export var title: String
@export var description: String
@export var dialogue: String
@export var actions: Array[BattleScores]
@export var rumor_targets: Array[String]

# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_actions: Array[BattleScores] = [],
	p_dialogue: String = "",
	p_rumor_targets: Array[String] = []
):
	title = p_title
	description = p_description
	actions = p_actions
	dialogue = p_dialogue
	rumor_targets = p_rumor_targets

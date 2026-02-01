extends Resource
class_name CardResource

var title: String
var description: String
var dialogue: String
var actions: Array[BattleScores]

# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_actions: Array[BattleScores] = [],
	p_dialogue: String = ""
):
	title = p_title
	description = p_description
	actions = p_actions
	dialogue = p_dialogue

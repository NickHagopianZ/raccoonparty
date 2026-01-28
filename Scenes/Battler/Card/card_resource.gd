extends Resource
class_name CardResource

var title: String
var description: String # Multiline gives you a bigger text box
var actions: Array[BattleScores.Action]

# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_actions: Array[BattleScores.Action] = [],
):
	title = p_title
	description = p_description
	actions = p_actions

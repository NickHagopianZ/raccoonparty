extends CardResource
class_name RumorCardResource

var rumor_targets: Array[String] = []
# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_actions: Array[BattleScores.Action] = [],
	p_rumor_targets: Array[String] = [],
):
	title = p_title
	description = p_description
	actions = p_actions
	rumor_targets = p_rumor_targets

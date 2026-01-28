extends Resource
class_name CardResource

@export var title: String
@export_multiline var description: String # Multiline gives you a bigger text box
@export var effects: Array[BattleScores.Effects]
@export var categories: Array[BattleScores.ScoreCategories]
@export var amounts: Array[int]

# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_effects: Array[BattleScores.Effects] = [],
	p_categories: Array[BattleScores.ScoreCategories] = [],
	p_amounts: Array[int] = [],
):
	title = p_title
	description = p_description
	effects = p_effects
	categories = p_categories
	amounts = p_amounts
	assert(len(effects) == len(categories), "different number of effects & categories")
	assert(len(effects) == len(amounts), "different number of effects & amounts")

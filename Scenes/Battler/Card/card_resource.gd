extends Resource
class_name CardResource

@export var title: String
@export var description: String
@export var dialogue: String
@export var actions: Array[BattleScores]
@export var rumor_targets: Array[String]
@export var play_effects : Array[int] = []

# A Resource still needs a parameterless constructor to save/load properly,
# so we give the arguments default values.
func _init(
	p_title: String = "",
	p_description: String = "",
	p_actions: Array[BattleScores] = [],
	p_dialogue: String = "",
	p_rumor_targets: Array[String] = [],
	p_play_effects : Array[int] = [],
):
	title = p_title
	description = p_description
	actions = p_actions
	dialogue = p_dialogue
	rumor_targets = p_rumor_targets
	play_effects = p_play_effects



var play_effect_map : Dictionary = {
	0: increase_equal_to_cards_discarded.bind(BattleScores.ScoreCategories.Vibes),
	1: increase_equal_to_cards_discarded.bind(BattleScores.ScoreCategories.Fear),
	2: increase_equal_to_cards_discarded.bind(BattleScores.ScoreCategories.Sus),
	3: defend_equal_to_turns_remaining.bind(BattleScores.ScoreCategories.Vibes),
	4: defend_equal_to_turns_remaining.bind(BattleScores.ScoreCategories.Fear),
	5: defend_equal_to_turns_remaining.bind(BattleScores.ScoreCategories.Sus),
	6: increase_all_based_on_strengthen,
	7: increase_equal_to_penalty_cards.bind(BattleScores.ScoreCategories.Vibes),
	8: increase_equal_to_penalty_cards.bind(BattleScores.ScoreCategories.Fear),
	9: increase_equal_to_penalty_cards.bind(BattleScores.ScoreCategories.Sus),
	10: increase_equal_to_npc_name_length.bind(BattleScores.ScoreCategories.Vibes),
	11: increase_equal_to_npc_name_length.bind(BattleScores.ScoreCategories.Fear),
	12: increase_equal_to_npc_name_length.bind(BattleScores.ScoreCategories.Sus),
}
func on_played():
	for play_effect_index in play_effects:
		call(play_effect_map[play_effect_index])

var battle_manager = null
func increase_equal_to_cards_discarded(category : BattleScores.ScoreCategories) -> void:
	var damage = battle_manager.cards_discarded
	var string_category = BattleScores.enum_to_string(category, BattleScores.ScoreCategories)
	actions.append(
		BattleScores.new(
			"Change",
			string_category,
			-damage
		)
	)


func defend_equal_to_turns_remaining(category : BattleScores.ScoreCategories) -> void:
	var damage = battle_manager.turns_remaining
	var string_category = BattleScores.enum_to_string(category, BattleScores.ScoreCategories)
	actions.append(
		BattleScores.new(
			"Defend",
			string_category,
			-damage
		)
	)


func increase_all_based_on_strengthen() -> void:
	for category in BattleScores.ScoreCategories.values():
		var total_strengthen = 0
		for status in battle_manager.statuses[category]:
			if status.effect == BattleScores.Effects.Strengthen:
				total_strengthen += status.amount
		var string_category = BattleScores.enum_to_string(category, BattleScores.ScoreCategories)
		actions.append(
			BattleScores.new(
				"Change",
				string_category,
				abs(total_strengthen)
			)
		)


func increase_equal_to_penalty_cards(category : BattleScores.ScoreCategories) -> void:
	var damage = battle_manager.penalty_deck.size()
	var string_category = BattleScores.enum_to_string(category, BattleScores.ScoreCategories)
	actions.append(
		BattleScores.new(
			"Change",
			string_category,
			-damage
		)
	)


func increase_equal_to_npc_name_length(category : BattleScores.ScoreCategories) -> void:
	var damage = battle_manager.curr_enemy.name.length()
	var string_category = BattleScores.enum_to_string(category, BattleScores.ScoreCategories)
	actions.append(
		BattleScores.new(
			"Change",
			string_category,
			-damage
		)
	)
extends Node


signal starting_battle(enemy : NPCEntity)
signal ending_battle
signal starting_interaction(partner : Node3D)
signal ending_interaction

var player_node : PlayerEntity
# Kevin : player deck can be stored here as a globally accessible variable
var player_deck : Deck = Deck.new()

var curr_enemy: NPCEntity

var curr_enemy_action: NPCEntity.NpcAction

var score_vibes: int
var score_fear: int
var score_sus: int

const WINNING_SCORE = 10
const STARTING_SCORE = 5

func start_battle(enemy : NPCEntity) -> void:
	player_deck.reset_deck()
	starting_battle.emit(enemy)
	curr_enemy = enemy

	score_vibes = STARTING_SCORE
	score_fear = STARTING_SCORE
	score_sus = STARTING_SCORE

	start_round()


func start_round():
	curr_enemy_action = curr_enemy.choose_battler_action()
	print(curr_enemy_action.message)
	# TODO: Display curr_enemy_action.message somewhere


func player_character_played_card(card: CardContainer):
	var actions = card.card_resource.actions
	var vibes_delta = 0
	var fear_delta = 0
	var sus_delta = 0
	var vibes_block = 0
	var fear_block = 0
	var sus_block = 0
	for action: BattleScores.Action in actions + curr_enemy_action.actions:
		if action.category == BattleScores.ScoreCategories.Vibes:
			if action.effect == BattleScores.Effects.Change:
				vibes_delta += action.amount
			else:
				vibes_block += action.amount
		elif action.category == BattleScores.ScoreCategories.Fear:
			if action.effect == BattleScores.Effects.Change:
				fear_delta += action.amount
			else:
				fear_block += action.amount
		elif action.category == BattleScores.ScoreCategories.Sus:
			if action.effect == BattleScores.Effects.Change:
				sus_delta += action.amount
			else:
				sus_block += action.amount

	if vibes_delta > 0:
		vibes_delta = max(0, (vibes_delta - vibes_block))
	else:
		vibes_delta = min(0, (vibes_delta + vibes_block))

	if sus_delta > 0:
		sus_delta = max(0, (sus_delta - sus_block))
	else:
		sus_delta = min(0, (sus_delta + sus_block))

	if fear_delta > 0:
		fear_delta = max(0, (fear_delta - fear_block))
	else:
		fear_delta = min(0, (fear_delta + fear_block))

	score_vibes += vibes_delta
	score_fear += fear_delta
	score_sus += sus_delta

	print("v:", score_vibes, " f:", score_fear, " s: ", score_sus)

	# TODO: handle loss/win
	# TODO: update UI displays of score

	start_round()


func end_battle() -> void:
	ending_battle.emit()


func start_npc_interaction(partner : Node3D) -> void:
	starting_interaction.emit(partner)


func end_npc_interaction() -> void:
	ending_interaction.emit()

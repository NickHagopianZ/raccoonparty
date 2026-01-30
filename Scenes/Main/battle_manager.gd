extends Control


# Kevin : this is not a bad place for a mega script for all the battler data + updating all the stats
# I left a bunch of color rects as placeholders for now
func _ready() -> void:
	visible = false
	GameManager.starting_battle.connect(_on_starting_battle)
	GameManager.ending_battle.connect(_on_ending_battle)
	GameManager.player_deck.card_played.connect(player_character_played_card)


var curr_enemy: NPCEntity

var curr_enemy_action: NPCEntity.NpcAction

var score_vibes: int
var score_fear: int
var score_sus: int

const WINNING_SCORE = 10
const STARTING_SCORE = 5


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
	_update_score_sliders()

	if score_vibes >= WINNING_SCORE or score_fear >= WINNING_SCORE or score_sus >= WINNING_SCORE:
		print("You win!")
		# TODO: do more on win
		GameManager.ending_battle.emit()
	elif score_vibes <= 0 or score_fear <= 0 or score_sus <= 0:
		print("You lose!")
		# TODO: do more on loss
		GameManager.ending_battle.emit()

	start_round()


func _update_score_sliders():
	$VBoxContainer/TextureRect/HBoxContainer/Stats/MarginContainer/VBoxContainer/HBoxContainer2/VibesSlider.value = 100.0 * score_vibes / WINNING_SCORE
	$VBoxContainer/TextureRect/HBoxContainer/Stats/MarginContainer/VBoxContainer/HBoxContainer/SusSlider.value = 100.0 * score_sus / WINNING_SCORE
	$VBoxContainer/TextureRect/HBoxContainer/Stats/MarginContainer/VBoxContainer/HBoxContainer3/FearSlider.value = 100.0 * score_fear / WINNING_SCORE


func _on_starting_battle(enemy : NPCEntity) -> void:
	visible = true

	curr_enemy = enemy

	score_vibes = STARTING_SCORE
	score_fear = STARTING_SCORE
	score_sus = STARTING_SCORE
	_update_score_sliders()

	start_round()


func _on_ending_battle() -> void:
	visible = false

extends Control


# Kevin : this is not a bad place for a mega script for all the battler data + updating all the stats
# I left a bunch of color rects as placeholders for now
func _ready() -> void:
	visible = false
	player_speech_bubble.visible = false
	npc_speech_bubble.visible = false
	player_speech_bubble.battle_manager = self
	npc_speech_bubble.battle_manager = self
	GameManager.starting_battle.connect(_on_starting_battle)
	GameManager.ending_battle.connect(_on_ending_battle)
	GameManager.player_deck.card_played.connect(_on_card_played)


var curr_enemy: NPCEntity

var curr_enemy_action: NPCAction

var scores := {
	BattleScores.ScoreCategories.Vibes: 0,
	BattleScores.ScoreCategories.Fear: 0,
	BattleScores.ScoreCategories.Sus: 0,
}

const WINNING_SCORE = 10
const STARTING_SCORE = 5
var tween_time_multiplier = 0.5

@export var npc_speech_label : RichTextLabel
@export var npc_speech_bubble : ActionDisplay
@export var player_speech_label : RichTextLabel
@export var player_speech_bubble : ActionDisplay
func start_round() -> Tween:
	print("[COMBAT] === ROUND START ===")
	print("[COMBAT] Turns remaining: ", turns_remaining)
	print(
		"[COMBAT] Current scores - Vibes: %d, Fear: %d, Sus: %d"
		% [scores[BattleScores.ScoreCategories.Vibes], scores[BattleScores.ScoreCategories.Fear], scores[BattleScores.ScoreCategories.Sus]]
	)
	_round_reset_statuses()
	_round_reset_sliders()
	GameManager.player_deck.fill_hand_if_needed()
	GameManager.can_play_cards = true
	player_speech_bubble.visible = false
	curr_enemy_action = curr_enemy.choose_battler_action()
	print("[COMBAT] Enemy chose action: ", curr_enemy_action.message)
	print("[COMBAT] Enemy actions: ", curr_enemy_action.actions)
	npc_speech_label.text = curr_enemy_action.message
	return pop_speech_bubble(npc_speech_bubble, npc_speech_label)


func pop_speech_bubble(speech_bubble: Control, rich_text_label: RichTextLabel):
	speech_bubble.visible = true
	rich_text_label.visible_ratio = 0.0
	speech_bubble.scale = Vector2(0.0, 0.0)

	var tween = create_tween()
	tween.tween_property(speech_bubble, "scale", Vector2(1.0, 1.0), 1.0 * tween_time_multiplier).set_trans(
		Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.set_parallel()
	tween.tween_property(rich_text_label, "visible_ratio", 1, 1.5 * tween_time_multiplier)
	return tween


@export var discarding_hint : Label
var cards_to_discard : int = 0
func _on_card_played(card: CardContainer) -> void:
	print("[COMBAT] Card played: ", card.card_resource.title)
	if cards_to_discard > 0:
		print("[COMBAT] Discarding card (cards left to discard: %d)" % (cards_to_discard - 1))
		cards_to_discard -= 1
		if cards_to_discard == 0 and discarding_hint:
			discarding_hint.text = "Discard " + str(cards_to_discard) + " cards"
			discarding_hint.visible = false
	else:
		resolve_player_turn(card)


# after player plays a card
func resolve_player_turn(card: CardContainer):
	resolve_player_turn_card_resource(card.card_resource)

func resolve_player_turn_card_resource(card_resource: CardResource) -> void:
	print("[COMBAT] === RESOLVING PLAYER TURN ===")
	print("[COMBAT] Player card: ", card_resource.title)
	print("[COMBAT] Card actions: ", card_resource.actions)
	GameManager.can_play_cards = false
	player_speech_label.text = card_resource.dialogue
	# Store the card_resource since the card may be freed before the callback
	var tween = pop_speech_bubble(player_speech_bubble, player_speech_label)
	tween.tween_callback(display_card_effects.bind(card_resource)).set_delay(3.0 * tween_time_multiplier)


func display_card_effects(card_resource : CardResource) -> void:  # Untyped to avoid tween callback type conversion issue
	print("[COMBAT] Displaying card effects...")
	var tween : Tween = create_tween()

	for _action in curr_enemy_action.actions:
		print("Displaying NPC effect : ", _action.to_display_string())
	for _action in card_resource.actions:
		print("Displaying card effect: ", _action.to_display_string())
	var delay = 3.0 * tween_time_multiplier
	npc_speech_bubble.display_actions(tween, curr_enemy_action.actions, delay * 0.4)
	tween.set_parallel(true)
	player_speech_bubble.display_actions(tween, card_resource.actions, delay * 0.4)

	tween.tween_callback(resolve_card_statuses.bind(card_resource)).set_delay(delay)


func resolve_card_statuses(card_resource : CardResource) -> void:  # Untyped to avoid tween callback type conversion issue
	print("[COMBAT] Resolving status effects (Defend, Nullify, Discard, Weaken, Strengthen)...")
	print(
		"[COMBAT] Current statuses - Vibes: %s, Fear: %s, Sus: %s"
		% [statuses[BattleScores.ScoreCategories.Vibes], statuses[BattleScores.ScoreCategories.Fear], statuses[BattleScores.ScoreCategories.Sus]]
	)
	var tween : Tween = create_tween()
	var delay = 3.0 * tween_time_multiplier
	npc_speech_bubble.trigger_actions(
		tween,
		curr_enemy_action.actions,
		[BattleScores.Effects.Defend,
		BattleScores.Effects.Nullify,
		BattleScores.Effects.Discard,
		BattleScores.Effects.Weaken,
		BattleScores.Effects.Strengthen],
		delay * 0.4,
	)
	player_speech_bubble.trigger_actions(
		tween,
		card_resource.actions,
		[BattleScores.Effects.Defend,
		BattleScores.Effects.Nullify,
		BattleScores.Effects.Discard,
		BattleScores.Effects.Weaken,
		BattleScores.Effects.Strengthen],
		delay * 0.4
	)
	tween.tween_callback(resolve_card_effects.bind(card_resource)).set_delay(delay)

func resolve_card_effects(card_resource : CardResource) -> void:  # Untyped to avoid tween callback type conversion issue
	print("[COMBAT] Resolving Change effects (damage/healing)...")
	var tween : Tween = create_tween()
	var delay = 3.0 * tween_time_multiplier
	npc_speech_bubble.trigger_actions(
		tween,
		curr_enemy_action.actions,
		[BattleScores.Effects.Change],
		delay * 0.4,
	)
	player_speech_bubble.trigger_actions(
		tween,
		card_resource.actions,
		[BattleScores.Effects.Change],
		delay * 0.4
	)
	tween.tween_callback(round_end).set_delay(delay)

var statuses := {
	BattleScores.ScoreCategories.Vibes: [] as Array[BattleScores],
	BattleScores.ScoreCategories.Fear: [] as Array[BattleScores],
	BattleScores.ScoreCategories.Sus: [] as Array[BattleScores],
	BattleScores.ScoreCategories.NONE: [] as Array[BattleScores],
}
func perform_action(action: BattleScores) -> void:
	if action.effect == BattleScores.Effects.Change:
		perform_change_effect(action)
	else:
		perform_status_effect(action)

@export var vibes_effect_displays : Dictionary[BattleScores.Effects, TextureRect]
@export var fear_effect_displays : Dictionary[BattleScores.Effects, TextureRect]
@export var sus_effect_displays : Dictionary[BattleScores.Effects, TextureRect]
var effect_displays : Dictionary = {
	BattleScores.ScoreCategories.Vibes: vibes_effect_displays,
	BattleScores.ScoreCategories.Fear: fear_effect_displays,
	BattleScores.ScoreCategories.Sus: sus_effect_displays,
}
func update_status_effect_displays() -> void:
	for category in effect_displays.keys():
		for effect in effect_displays[category].keys():
			var texture_rect : TextureRect = effect_displays[category][effect] as TextureRect
			if not texture_rect:
				continue
			var label : Label = texture_rect.get_node("Label") as Label
			texture_rect.visible = false
			# Find the status effect for this category
			for status in statuses[category]:
				if status.effect == effect:
					texture_rect.visible = true
					if effect == BattleScores.Effects.Weaken:
						texture_rect.tooltip_text = ("Your weakened and enemy \n" +
							"attacks against you are \ninreased for " + str(status.amount) + " turns")
					elif effect == BattleScores.Effects.Strengthen:
						texture_rect.tooltip_text = ("Your card increases are \nstrengthened" +
							"for " + str(status.amount) + " turns")
					if label:
						label.text = "x" + str(status.amount)
					break



func perform_status_effect(action: BattleScores) -> void:
	print("[COMBAT] Applying status effect: %s" % action.to_display_string())
	if action.effect == BattleScores.Effects.Discard:
		cards_to_discard = min(
			cards_to_discard + action.amount,
			GameManager.player_deck.hand.size())
		print("[COMBAT] Player must discard %d cards" % cards_to_discard)
		if discarding_hint:
			discarding_hint.visible = true
			discarding_hint.text = "Discard " + str(cards_to_discard) + " cards"
		return  # No status to apply
	elif action.effect in [
		BattleScores.Effects.Weaken,
		BattleScores.Effects.Strengthen]:
		# Find existing effect of same type for this category and stack turns
		var found = false
		for effect in statuses[action.category]:
			if effect.effect == action.effect:
				effect.amount += action.amount
				found = true
				break
		if not found:
			statuses[action.category].append(action)
		print("[COMBAT] %s on %s now at %d turns" % [
			BattleScores.enum_to_string(action.effect, BattleScores.Effects),
			BattleScores.enum_to_string(action.category, BattleScores.ScoreCategories),
			action.amount
		])
	elif action.effect in [
		BattleScores.Effects.Defend,
		BattleScores.Effects.Nullify]:
		statuses[action.category].append(action)
	
	# Update slider for all status effects (not just Defend/Nullify)
	if action.category in sliders and sliders[action.category]:
		var slider = sliders[action.category]
		var score = scores[action.category]
		var status_list = statuses[action.category]
		slider.update_slider(score, status_list)


func perform_change_effect(action: BattleScores) -> void:
	var slider = sliders[action.category]
	var original_amount = action.amount
	var amount = action.amount
	print("[COMBAT] Change effect %s" % action.to_display_string())

	for status : BattleScores in statuses[action.category]:
		if status.effect == BattleScores.Effects.Weaken and amount < 0: # take more damage
			var old_amount = amount
			amount = int(amount * 2)
			print("[COMBAT]   Weaken applied: %d -> %d" % [old_amount, amount])
		elif status.effect == BattleScores.Effects.Defend and amount < 0:
			var old_amount = amount
			amount += abs(status.amount)
			amount = max(0, amount)
			print("[COMBAT]   Defend blocked: %d -> %d (blocked %d)" % [old_amount, amount, status.amount])
			statuses[action.category].erase(status)
		elif status.effect == BattleScores.Effects.Nullify and amount > 0:
			var old_amount = amount
			amount -= abs(status.amount)
			amount = min(0, amount)
			print("[COMBAT]   Nullify blocked: %d -> %d (blocked %d)" % [old_amount, amount, status.amount])
			statuses[action.category].erase(status)
		elif status.effect == BattleScores.Effects.Strengthen and amount > 0: # heal more
			var old_amount = amount
			amount = int(amount * 2)
			print("[COMBAT]   Strengthen applied: %d -> %d" % [old_amount, amount])

	print("[COMBAT]   Final change: %d (was %d), new score: %d" % [amount, original_amount, scores[action.category] + amount])
	scores[action.category] += amount
	slider.update_slider(scores[action.category], statuses[action.category])


const STARTING_TURNS = 10
var turns_remaining: int = STARTING_TURNS
@export var turn_counter : Label
func round_end() -> void:
	print("[COMBAT] === ROUND END ===")
	turns_remaining -= 1
	print("[COMBAT] Turns remaining: ", turns_remaining)
	print(
		"[COMBAT] Final scores - Vibes: %d, Fear: %d, Sus: %d"
		% [scores[BattleScores.ScoreCategories.Vibes], scores[BattleScores.ScoreCategories.Fear], scores[BattleScores.ScoreCategories.Sus]]
	)
	turn_counter.text = str(turns_remaining) + " turns to survive"
	if (scores[BattleScores.ScoreCategories.Vibes] >= WINNING_SCORE
		or scores[BattleScores.ScoreCategories.Fear] >= WINNING_SCORE
		or scores[BattleScores.ScoreCategories.Sus] >= WINNING_SCORE
		or turns_remaining <= 0):
		print("[COMBAT] *** VICTORY! ***")
		GameManager.ending_battle.emit(true)
	elif (scores[BattleScores.ScoreCategories.Vibes] <= 0
		or scores[BattleScores.ScoreCategories.Fear] <= 0
		or scores[BattleScores.ScoreCategories.Sus] <= 0):
		print("[COMBAT] *** DEFEAT! ***")
		GameManager.ending_battle.emit(false)

	start_round()


@export var sliders: Dictionary[BattleScores.ScoreCategories, LerpSlider] = {
	BattleScores.ScoreCategories.Sus: null,
	BattleScores.ScoreCategories.Fear: null,
	BattleScores.ScoreCategories.Vibes: null,
}

# reduce strengthen and weaken statuses and remove defend, nullify. Ignore and discard statuses
func _round_reset_statuses() -> void:
	for status in statuses.keys():
		var new_statuses : Array[BattleScores] = []
		for status_effect in statuses[status]:
			if status_effect.effect in [
				BattleScores.Effects.Defend,
				BattleScores.Effects.Nullify]:
				# these expire at end of round
				continue
			elif status_effect.effect in [
				BattleScores.Effects.Strengthen,
				BattleScores.Effects.Weaken]:
				status_effect.amount -= 1
				if status_effect.amount > 0:
					new_statuses.append(status_effect)
		statuses[status] = new_statuses
	update_status_effect_displays()

func _reset_statuses():
	statuses = {
		BattleScores.ScoreCategories.Vibes: [] as Array[BattleScores],
		BattleScores.ScoreCategories.Fear: [] as Array[BattleScores],
		BattleScores.ScoreCategories.Sus: [] as Array[BattleScores],
		BattleScores.ScoreCategories.NONE: [] as Array[BattleScores],
	}


func _reset_scores():
	scores = {
		BattleScores.ScoreCategories.Vibes: STARTING_SCORE,
		BattleScores.ScoreCategories.Fear: STARTING_SCORE,
		BattleScores.ScoreCategories.Sus: STARTING_SCORE,
	}


func _round_reset_sliders() -> void:
	for category in sliders.keys():
		var slider = sliders[category]
		if slider and category in scores and category in statuses:
			slider.update_slider(scores[category], statuses[category])


func _on_starting_battle(enemy : NPCEntity) -> void:
	print("[COMBAT] ========================================")
	print("[COMBAT] BATTLE STARTED vs ", enemy.name)
	print("[COMBAT] ========================================")
	visible = true
	$ScoreTutorialBox.visible = GameManager.first_battle
	_reset_statuses()
	_reset_scores()
	update_status_effect_displays()
	curr_enemy = enemy
	turns_remaining = STARTING_TURNS
	turn_counter.text = str(turns_remaining) + " turns to survive"
	player_speech_bubble.reset()
	npc_speech_bubble.reset()
	for slider in sliders.values():
		slider.reset(STARTING_SCORE, WINNING_SCORE)

	print("[COMBAT] All sliders reset to ", STARTING_SCORE)
	var tween : Tween = start_round()
	# if no cards in player's deck, end battle immediately with defeat
	if enemy.name == "Bouncer" and no_cards_to_play():
		print("[COMBAT] Player has no cards in deck! Immediate defeat.")
		var default_bouncer_card = resolve_player_turn_card_resource.bind(CardResource.new(
				"Make Something Up",
				"Darren",
				[],
				"Oh... Uh... Darren",
			)
		)
		tween.set_parallel(false)
		tween.tween_callback(default_bouncer_card)
	elif no_cards_to_play():
		var fumble_card_resource = CardResource.new(
			"Fumble",
			"Is this all you've got?",
			[
				BattleScores.new("Change", "Sus", -2),
				BattleScores.new("Change", "Fear", -2),
				BattleScores.new("Change", "Vibes", -2),
			],
			"Oh gosh, I forgot what I was going to say!",
		)
		GameManager.player_deck.draw_pile = [fumble_card_resource]
		GameManager.player_deck.fill_hand_if_needed()


func no_cards_to_play() -> bool:
	return (GameManager.player_deck.hand.size() == 0
		and GameManager.player_deck.draw_pile.size() == 0
		and GameManager.player_deck.discard.size() == 0)


func _on_ending_battle(_was_victory: bool) -> void:
	GameManager.first_battle = false
	visible = false

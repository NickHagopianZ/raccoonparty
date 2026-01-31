extends Control
class_name ActionDisplay

@export var spawn_box : Vector2 = Vector2(200, 200)
@export var target_region : Control
# creates floating text visuals for each action in the spawn box
const temp_visual = preload("res://Assets/UI/InteractBox.png")
const sus_visual = preload("res://Assets/Actions/sus_icon.png")
# const vibes_visual = preload("res://Assets/Actions/vibes_icon.png")
const fear_visual = preload("res://Assets/Actions/fear_icon.png")
# const nullify_icon = preload("res://Assets/Actions/nullify_icon.png")
const defend_icon = preload("res://Assets/Actions/defend_icon.png")
# const change_icon = preload("res://Assets/Actions/change_icon.png")
# const weaken_icon = preload("res://Assets/Actions/weaken_icon.png")
# const strengthen_icon = preload("res://Assets/Actions/strengthen_icon.png")
# const discard_icon = preload("res://Assets/Actions/discard_icon.png")
var active_displays : Dictionary = {}
var battle_manager : Control = null

func reset() -> void:
	for display in active_displays.values():
		display.queue_free()
	active_displays.clear()


func display_actions(
	tween: Tween,
	actions: Array[BattleScores.Action],
	) -> void:
	tween.parallel()
	for action in actions:
		for count in range(action.amount):
			var texture_rect = TextureRect.new()
			texture_rect.top_level = true
			match action.effect:
				BattleScores.Effects.Nullify:
					texture_rect.texture = temp_visual
					texture_rect.modulate = Color(1, 0, 0)
				BattleScores.Effects.Defend:
					texture_rect.texture = defend_icon
					texture_rect.modulate = Color(0, 1, 0)
				BattleScores.Effects.Change:
					if action.category == BattleScores.ScoreCategories.Vibes:
						texture_rect.texture = temp_visual
						texture_rect.modulate = Color(1, 0.5, 0)
					elif action.category == BattleScores.ScoreCategories.Fear:
						texture_rect.texture = fear_visual
						texture_rect.modulate = Color(0.5, 0, 1)
					elif action.category == BattleScores.ScoreCategories.Sus:
						texture_rect.texture = sus_visual
						texture_rect.modulate = Color(1, 1, 1)
				BattleScores.Effects.Weaken:
					texture_rect.texture = temp_visual
					texture_rect.modulate = Color(1, 1, 0)
				BattleScores.Effects.Strengthen:
					texture_rect.texture = temp_visual
					texture_rect.modulate = Color(0, 1, 1)
				BattleScores.Effects.Discard:
					texture_rect.texture = temp_visual
					texture_rect.modulate = Color(1, 0, 1)
				_: # Don't create anything outside of these
					continue
			
			if action.effect in [
				BattleScores.Effects.Nullify,
				BattleScores.Effects.Defend,
				BattleScores.Effects.Change,
				BattleScores.Effects.Weaken,
				BattleScores.Effects.Strengthen]:
				var label : Label = Label.new()
				if action.amount < 0:
					label.text = "-"
				else:
					label.text = "+"
				if BattleScores.Effects.Change != action.effect:
					if action.category == BattleScores.ScoreCategories.Vibes:
						label.text += " Vibes"
					elif action.category == BattleScores.ScoreCategories.Fear:
						label.text += " Fear"
					elif action.category == BattleScores.ScoreCategories.Sus:
						label.text += " Sus"
				label.position.x += 40
				label.position.y -= 40
				texture_rect.add_child(label)

			# texture_rect.scale *= 3.0
			texture_rect.global_position = global_position
			texture_rect.global_position += Vector2(
				randf_range(0, spawn_box.x),
				randf_range(0, spawn_box.y))

			texture_rect.modulate.a = 0.0
			add_child(texture_rect)
			tween.tween_property(
				texture_rect, "modulate:a", 1.0, .3).set_delay(randf_range(0.0, 0.5))
			if action.effect not in active_displays:
				active_displays[action.effect] = []
			active_displays[action.effect].append(texture_rect)

@export_enum("Player", "Enemy") var source : String = "Player"
func trigger_actions(
	tween: Tween,
	actions: Array[BattleScores.Action],
	action_subset : Array[BattleScores.Effects]
	) -> void:
	tween.parallel()
	for action in actions:
		for count in range(abs(action.amount)):
			if action.amount > 0:
				action.amount = 1  # Process one at a time for visuals
			else:
				action.amount = -1

			if (action_subset == [] or action.effect in action_subset) and action.effect in active_displays:
				var display = active_displays[action.effect][0]
				var target_global_position = target_region.global_position
				target_global_position += Vector2(
					randf_range(0, target_region.size.x),
					randf_range(0, target_region.size.y)) * .5
				tween.tween_property(
					display, "global_position", target_global_position, 0.5
				).set_delay(randf_range(0.0, 0.5))
				tween.tween_callback(display.queue_free)
				tween.tween_callback(battle_manager.perform_action.bind(action))
				active_displays[action.effect].erase(display)
				if active_displays[action.effect].size() == 0:
					active_displays.erase(action.effect)

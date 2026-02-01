extends Control
class_name LerpSlider

@export var health_slider : HSlider
@export var empty_slider : HSlider
@export var damage_lerp_slider : HSlider
@export var defense_slider : HSlider
@export var nullify_slider : HSlider
var max_value : float = 100
var lerp_speed : float = 1.0
func _ready() -> void:
	health_slider.max_value = max_value
	empty_slider.max_value = max_value
	damage_lerp_slider.max_value = max_value
	health_slider.value = max_value
	empty_slider.value = max_value
	damage_lerp_slider.value = max_value

var damage_lerp_tween : Tween = null
var healing_lerp_tween : Tween = null
var defense_lerp_tween : Tween = null
func update_slider(final_amount: float, statuses: Array[BattleScores]) -> void:
	for tween in [damage_lerp_tween, healing_lerp_tween, defense_lerp_tween]:
		if tween and tween.is_running():
			tween.kill()

	var clamped_value = clamp(final_amount, 0, max_value)
	
	# Apply defense effects
	var defense_amount : float = 0
	# var nullify_amount : float = 0
	for status in statuses:
		if status.effect == BattleScores.Effects.Defend:
			defense_amount += status.amount
		# elif status.effect == BattleScores.Effects.Nullify:
			# nullify_amount += status.amount
	if defense_amount > 0:
		defense_amount += final_amount
		defense_lerp_tween = create_tween()
		defense_lerp_tween.tween_property(
			defense_slider, "value", defense_amount, lerp_speed)
	else:
		defense_slider.value = 0

	if clamped_value > health_slider.value: # Healing or increase
		healing_lerp_tween = create_tween()
		healing_lerp_tween.tween_property(health_slider, "value", clamped_value, lerp_speed)
	else: # Damage or decrease
		damage_lerp_slider.value = health_slider.value
		health_slider.value = clamped_value
		damage_lerp_tween = create_tween()
		damage_lerp_tween.tween_property(damage_lerp_slider, "value", health_slider.value, lerp_speed)

func reset(_value : float, _max_value : float) -> void:
	max_value = _max_value
	health_slider.max_value = max_value
	empty_slider.max_value = max_value
	damage_lerp_slider.max_value = max_value
	defense_slider.max_value = max_value
	nullify_slider.max_value = max_value

	empty_slider.value = max_value
	defense_slider.value = 0
	nullify_slider.value = 0

	health_slider.value = _value
	damage_lerp_slider.value = _value

func turn_end() -> void:
	defense_slider.value = 0
	nullify_slider.value = 0

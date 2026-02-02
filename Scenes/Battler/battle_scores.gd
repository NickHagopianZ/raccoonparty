extends Resource
class_name BattleScores
enum ScoreCategories {
	Vibes,
	Fear,
	Sus,
	NONE
}
enum Effects {
	Change,
	Defend,
	Weaken,
	Strengthen,
	Discard,
	Nullify,
	Exhaust, # card is removed from the game, used for penalty cards
}

@export var effect: Effects
@export var category: ScoreCategories
@export var amount: int


func _init(_effect : String = "", _category : String = "", _amount : int = 0) -> void:
	if _effect != "":
		effect = string_to_enum(_effect, Effects) as Effects
	if _category != "":
		category = string_to_enum(_category, ScoreCategories) as ScoreCategories
	self.amount = _amount


static func string_to_enum(string, enum_map) -> int:
	for key in enum_map.keys():
		if key.to_lower() == string.to_lower():
			return enum_map[key] as int
	return -1


static func enum_to_string(value: int, enum_map) -> String:
	for key in enum_map.keys():
		if enum_map[key] == value:
			return key
	return ""



func to_display_string() -> String:
	var effect_str = Effects.keys()[effect]
	var category_str = ScoreCategories.keys()[category]
	return "Category: " + category_str + ", Effect: " + effect_str + ", Amount: " + str(amount)

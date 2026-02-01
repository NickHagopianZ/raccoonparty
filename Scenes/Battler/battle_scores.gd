extends Resource
class_name BattleScores
enum ScoreCategories {
	Vibes,
	Fear,
	Sus,
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

var effect: Effects
var category: ScoreCategories
var amount: int

func _init(p_input: String = ""):
	if p_input == "": return

	# Pattern: ([+-D])? captures the prefix, (\d+) captures the number,
	# and (\w+) captures the category name.
	var regex = RegEx.new()
	regex.compile("([+-D])(\\d+)\\s+(\\w+)")

	var result = regex.search(p_input)
	if result:
		var prefix = result.get_string(1)
		var val_str = result.get_string(2)
		var cat_str = result.get_string(3)

		# 1. Parse Effect
		if prefix == "D":
			effect = Effects.Defend
		elif prefix in ['-', '+']:
			effect = Effects.Change
		else:
			push_error("Unknown prefix for action string: " + prefix)

		# 2. Parse Amount
		amount = val_str.to_int()
		if prefix == "-":
			amount *= -1

		# 3. Parse Category (Case-insensitive matching)
		for key in ScoreCategories.keys():
			if key.to_lower() == cat_str.to_lower():
				category = ScoreCategories[key]
				break
	else:
		push_error("Failed to parse Action string: " + p_input)

	self.effect = effect
	self.category = category
	self.amount = amount


func to_display_string() -> String:
	var effect_str = Effects.keys()[effect]
	var category_str = ScoreCategories.keys()[category]
	return "Category: " + category_str + ", Effect: " + effect_str + ", Amount: " + str(amount)

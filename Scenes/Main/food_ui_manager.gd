extends Control

func _ready():
	GameManager.starting_interaction.connect(_hide)
	GameManager.ending_interaction.connect(_update_food_ui)
	GameManager.starting_game.connect(_update_food_ui)


func _hide(_x):
	self.visible = false


func _update_food_ui():
	self.visible = true
	if GameManager.total_food_available > 0:
		var ratio = float(GameManager.food_counter) / GameManager.total_food_available
		var full_size = $MarginContainer/OuterFoodSlider/InnerFoodContainer.size.x
		$MarginContainer/OuterFoodSlider/InnerFoodContainer/InnerFoodSlider.custom_minimum_size.x = clamp(ratio * full_size, 5.0, INF)
		if GameManager.found_all_food():
			GameManager.all_food_found.emit()

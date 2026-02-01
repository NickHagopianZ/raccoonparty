extends Control

func _ready():
	GameManager.starting_interaction.connect(_hide)
	GameManager.ending_interaction.connect(_show)

func _process(_delta: float):
	if GameManager.total_food_available > 0:
		var ratio = float(GameManager.food_counter) / GameManager.total_food_available
		var full_size = $MarginContainer/OuterFoodSlider/InnerFoodContainer.size.x
		$MarginContainer/OuterFoodSlider/InnerFoodContainer/InnerFoodSlider.custom_minimum_size.x = clamp(ratio * full_size, 5.0, INF)

func _hide(_x):
	self.visible = false

func _show():
	self.visible = true

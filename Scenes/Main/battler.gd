extends Control


# Kevin : this is not a bad place for a mega script for all the battler data + updating all the stats
# I left a bunch of color rects as placeholders for now
func _ready() -> void:
	visible = false
	GameManager.starting_battle.connect(_on_starting_battle)
	GameManager.ending_battle.connect(_on_ending_battle)


func _on_starting_battle(_enemy : NPCEntity) -> void:
	visible = true


func _on_ending_battle() -> void:
	visible = false

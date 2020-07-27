extends MarginContainer


onready var score: HBoxContainer = $Elements/FirstRow/Score
onready var lifes: HBoxContainer = $Elements/FirstRow/Lifes


# Public API
func update_life_value(value: int) -> int:
	return lifes.update_lifes(value)


func update_score(value: int) -> int:
	return score.update_value(value)

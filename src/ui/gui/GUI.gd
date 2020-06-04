extends MarginContainer


onready var score: HBoxContainer = $Elements/Score


# Public API
func update_score(value: int) -> int:
	return score.update_value(value)

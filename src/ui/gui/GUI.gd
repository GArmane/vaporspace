extends MarginContainer


onready var score: HBoxContainer = $Elements/FirstRow/Score
onready var lifes: HBoxContainer = $Elements/FirstRow/Lifes


# Public API
func update_life_values(value: int, max_value: int) -> Array:
	return lifes.update_values(value, max_value)


func update_life_value(value: int) -> int:
	return lifes.update_lifes(value)


func update_life_max_value(value: int) -> int:
	return lifes.update_max(value)


func update_score(value: int) -> int:
	return score.update_value(value)


func _on_Player_lifes_changed(value):
	pass # Replace with function body.

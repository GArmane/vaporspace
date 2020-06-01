extends CanvasLayer


onready var score := 0


func add_score(value: int) -> int:
	score += value
	get_node("BaseContainer/Elements/Score/Value").text = str(score)
	return score

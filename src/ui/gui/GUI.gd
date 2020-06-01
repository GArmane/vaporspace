extends CanvasLayer


func update_score(value: int) -> int:
	get_node("BaseContainer/Elements/Score/Value").text = str(value)
	return value

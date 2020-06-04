extends HBoxContainer


onready var value_node: Label = $Value


# Public API
func update_value(value: int) -> int:
	value_node.text = str(value)
	return value

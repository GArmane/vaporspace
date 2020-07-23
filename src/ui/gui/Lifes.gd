extends HBoxContainer


onready var value_node: Label = $Value
onready var max_value_node: Label = $MaxValue


# Public API
func update_values(value: int, max_value: int) -> Array:
	return [update_lifes(value), update_max(max_value)]


func update_lifes(value: int) -> int:
	value_node.text = str(value)
	return value


func update_max(value: int) -> int:
	max_value_node.text = str(value)
	return value

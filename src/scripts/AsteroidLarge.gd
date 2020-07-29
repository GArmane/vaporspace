extends "res://src/scripts/AsteroidBase.gd"

onready var child_spawner: Node = $ChildSpawner


# Private API
func _spawn_childs() -> void:
	# Create childs
	var asteroids = child_spawner.create_childs(position)
	
	var destroy_handlers := get_signal_connection_list("destroyed")
	for asteroid in asteroids:  # type: RigidBody2D
		# Connect necessary handlers to childs
		for handler in destroy_handlers:  # type: Dictionary
			asteroid.connect("destroyed", handler["target"], handler["method"])
		# Spawn childs
		get_parent().add_child_below_node(self, asteroid)


# Public API
func destroy(points_to_award: int) -> void:
	.destroy(points_to_award)
	_spawn_childs()

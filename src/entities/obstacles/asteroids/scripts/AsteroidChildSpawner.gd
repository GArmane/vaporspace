extends Node

export (PackedScene) var child_asteroid

onready var rng := RandomNumberGenerator.new()

export var childs_to_spawn := 2
export var chance_to_spawn_child := 0.2
export var lin_velocity_child_lower_bound := Vector2(-200, -200)
export var lin_velocity_child_upper_bound := Vector2(200, 200)
export var ang_velocity_child_lower_bound := -5
export var ang_velocity_child_upper_bound := 5


# Public API
func create_childs(position: Vector2) -> Array:
	var childs = []
	for i in childs_to_spawn:
		if randf() <= chance_to_spawn_child:
			var lin_velocity := _rand_vector(
				lin_velocity_child_lower_bound,
				lin_velocity_child_upper_bound
			)
			var ang_velocity := rand_range(
				ang_velocity_child_lower_bound,
				ang_velocity_child_upper_bound
			)
			childs.append(child_asteroid.instance().initialize(
				position, lin_velocity, ang_velocity
			))
	return childs


# Private API
func _rand_vector(start: Vector2, end: Vector2) -> Vector2:
	return Vector2(rand_range(start.x, end.x), rand_range(start.y, end.y))


# Callbacks
func _ready():
	rng.randomize()

extends Node2D


const asteroid_node = preload("res://src/entities/obstacles/asteroids/Asteroid.tscn")

onready var container: Node2D = $Container
onready var rng := RandomNumberGenerator.new()


# Positional parameters
export var position_start := Vector2(0, 0)
export var position_end := Vector2(0, 0)
export var offset := 16

# Linear velocity parameters
export var linear_velocity_start := Vector2(0, 0)
export var linear_velocity_end := Vector2(0, 0)

# Angular velocity parameters
export var angular_velocity_start := 0
export var angular_velocity_end := 0


func _rand_vector(start: Vector2, end: Vector2) -> Vector2:
	return Vector2(rand_range(start.x, end.x), rand_range(start.y, end.y))


func _set_model(asteroid: RigidBody2D) -> RigidBody2D:
	var index = rng.randi_range(0, 3)
	asteroid.switch_model(index)
	return asteroid


func _set_physics(asteroid: RigidBody2D) -> RigidBody2D:
	asteroid.position = _rand_vector(position_start, position_end)
	asteroid.linear_velocity = _rand_vector(
		linear_velocity_start, linear_velocity_end
	)
	asteroid.angular_velocity = rand_range(
		angular_velocity_start, angular_velocity_end
	)
	return asteroid


func spawn():
	var asteroid := _set_model(_set_physics(asteroid_node.instance()))
	container.add_child(asteroid)


func _ready():
	rng.randomize()

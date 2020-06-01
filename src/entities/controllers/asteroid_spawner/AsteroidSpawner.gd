extends Position2D


signal wave_start
signal wave_end


const asteroids = [
	preload("res://src/entities/obstacles/asteroids/AsteroidLarge01.tscn"),
	preload("res://src/entities/obstacles/asteroids/AsteroidLarge02.tscn"),
	preload("res://src/entities/obstacles/asteroids/AsteroidMedium01.tscn"),
	preload("res://src/entities/obstacles/asteroids/AsteroidSmall01.tscn"),
]


onready var container: Node2D = $Container
onready var rng := RandomNumberGenerator.new()
onready var start_timer: Timer = $StartTimer
onready var spawn_timer: Timer = $SpawnTimer


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

# Asteroid wave parameters
export var wave_count := 10


func _ready():
	rng.randomize()


func _choose_random_asteroid() -> RigidBody2D:
	var index = rng.randi_range(0, len(asteroids) - 1)
	return asteroids[index].instance()


func _rand_vector(start: Vector2, end: Vector2) -> Vector2:
	return Vector2(rand_range(start.x, end.x), rand_range(start.y, end.y))


func _set_physics(asteroid: RigidBody2D) -> RigidBody2D:
	asteroid.position = _rand_vector(position_start, position_end)
	asteroid.linear_velocity = _rand_vector(
		linear_velocity_start, linear_velocity_end
	)
	asteroid.angular_velocity = rand_range(
		angular_velocity_start, angular_velocity_end
	)
	return asteroid


func spawn(controller: Object, handler: String):
	var asteroid = _set_physics(_choose_random_asteroid())
	asteroid.connect("destroyed", controller, handler)
	get_parent().add_child_below_node(self, asteroid)


func spawn_wave(
	controller: Object, handler: String, spawn_interval: float, count: int
) -> void:
	spawn_timer.wait_time = spawn_interval
	emit_signal("wave_start")

	spawn_timer.start()
	for _count in range(0, count):
		yield(spawn_timer, "timeout")
		spawn(controller, handler)

	spawn_timer.stop()
	emit_signal("wave_end")

extends Position2D


signal enemy_destroyed(enemy, args)


export (PackedScene) var scene_to_spawn
onready var scene_to_spawn_ref = load(scene_to_spawn.get_path())

onready var animator: AnimationPlayer = $Animator
onready var spawn_timer: Timer = $SpawnTimer
onready var events_to_map := []

export (float) var min_wait_time
export (float) var max_wait_time



# Callbacks
func _ready():
	randomize()


# Public API
func set_events_mapping(events_mapping: Array) -> void:
	events_to_map = events_mapping


func start():
	spawn_timer.start()


func stop():
	spawn_timer.stop()


func has_started() -> bool:
	return !spawn_timer.is_stopped()


# Signal handlers
func _on_SpawnTimer_timeout():
	var instance = scene_to_spawn_ref.instance()
	
	get_parent().add_child(instance)
	instance.set_global_position(get_global_position())
	for events in events_to_map:
		match events:
			[var event_name, var controller, var handler]:
				instance.connect(event_name, controller, handler)
			_:
				push_error("wrong mapping passed to spawner")
	
	spawn_timer.set_wait_time(rand_range(min_wait_time, max_wait_time))
	spawn_timer.start()

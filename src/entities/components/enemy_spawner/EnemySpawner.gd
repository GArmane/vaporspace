extends Position2D


export (PackedScene) var scene_to_spawn
onready var scene_to_spawn_ref = load(scene_to_spawn.get_path())

onready var animator: AnimationPlayer = $Animator
onready var spawn_timer: Timer = $SpawnTimer

export (float) var min_wait_time
export (float) var max_wait_time


# Callbacks
func _ready():
	randomize()
	start()


# Public API
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
	
	spawn_timer.set_wait_time(rand_range(min_wait_time, max_wait_time))
	spawn_timer.start()

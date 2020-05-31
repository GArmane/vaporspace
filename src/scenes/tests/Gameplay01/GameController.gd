extends Node2D


onready var asteroid_spawner: Position2D = $AsteroidSpawner
onready var start_timer: Timer = $StartTimer


func _ready():
	start_timer.start()


func _on_StartTimer_timeout():
	asteroid_spawner.spawn_wave(0.5, 10)
	yield(asteroid_spawner, "wave_end")
	start_timer.start()

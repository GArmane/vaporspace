extends Node2D


onready var asteroid_spawner: Position2D = $AsteroidSpawner
onready var gui: CanvasLayer = $GUI
onready var start_timer: Timer = $StartTimer


onready var score := 0


func _ready():
	start_timer.start()


func _on_StartTimer_timeout():
	asteroid_spawner.spawn_wave(self, "_on_Asteroid_destroy", 0.5, 10)
	yield(asteroid_spawner, "wave_end")
	start_timer.start()


func _on_Asteroid_destroy(value: int) -> void:
	score += value
	gui.update_score(score)

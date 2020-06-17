extends Node2D


onready var asteroid_spawner: Position2D = $AsteroidSpawner
onready var gui: MarginContainer = $CanvasLayer/GUI
onready var game_over_ui: Control = $CanvasLayer/GameOverUI
onready var reload_timer: Timer = $Timers/ReloadTimer
onready var start_timer: Timer = $Timers/StartTimer


onready var score := 0


# Callbacks
func _ready() -> void:
	# Prepare UI
	game_over_ui.hide()
	gui.update_score(score)

	start_timer.start()


# Signal handlers
func _on_Asteroid_destroy(value: int) -> void:
	score += value
	gui.update_score(score)


func _on_StartTimer_timeout() -> void:
	asteroid_spawner.spawn_wave(self, "_on_Asteroid_destroy", 0.5, 10)
	yield(asteroid_spawner, "wave_end")
	start_timer.start()


func _on_Player_dead():
	game_over_ui.show()
	reload_timer.start()


func _on_ReloadTimer_timeout() -> void:
	var _res = get_tree().reload_current_scene()

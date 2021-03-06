extends Node2D


# Spawners
onready var asteroid_spawner: Position2D = $AsteroidSpawner
onready var kamizake_spawner: Position2D = $KamizakeSpawner

# UI elements
onready var gui: MarginContainer = $CanvasLayer/GUI
onready var game_over_ui: Control = $CanvasLayer/GameOverUI

# Player
onready var player: KinematicBody2D = $Player

# Timers
onready var game_timer: Timer = $Timers/GameTimer
onready var reload_timer: Timer = $Timers/ReloadTimer
onready var wave_timer: Timer = $Timers/WaveTimer


onready var score := 0
onready var wave_counter := 0
export var game_time := 170
export var time_to_reload_after_death := 5
export var time_to_reload_after_end := 8
export var time_between_waves := 3


# Private API
func _reload_scene() -> void:
	var _res = get_tree().reload_current_scene()


func _end_game(restart_time: int) -> void:
	game_over_ui.show()
	wave_timer.stop()
	reload_timer.wait_time = restart_time
	reload_timer.start()


func _spawn_wave() -> void:
	wave_counter += 1
	if wave_counter >= 3 and !kamizake_spawner.has_started():
		kamizake_spawner.start()

	asteroid_spawner.spawn_wave(self, "_on_Entity_destroy", 0.5, 10)
	yield(asteroid_spawner, "wave_end")
	wave_timer.start()


# Callbacks
func _ready() -> void:
	# Prepare UI
	gui.update_score(score)
	gui.update_life_value(player.lifes)
	# Prepare spawners
	kamizake_spawner.set_events_mapping([
		["destroyed", self, "_on_Entity_destroy"]
	])
	# Prepare timers
	game_timer.wait_time = game_time
	wave_timer.wait_time = time_between_waves
	# Start game
	wave_timer.start()


# Signal handlers
func _on_Entity_destroy(value: int) -> void:
	score += value
	gui.update_score(score)


func _on_GameTimer_timeout():
	_end_game(time_to_reload_after_end)


func _on_WaveTimer_timeout() -> void:
	_spawn_wave()


func _on_Player_dead():
	_end_game(time_to_reload_after_death)


func _on_Player_lifes_changed(value):
	gui.update_life_value(value)


func _on_ReloadTimer_timeout() -> void:
	_reload_scene()

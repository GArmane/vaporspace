extends RigidBody2D


signal destroyed(points)


onready var destroy_sfx: AudioStreamPlayer = $AudioPlayers/DestroySFX
onready var collision_shape: CollisionShape2D = $CollisionShape2D

export var points := 10


# Public API
func destroy(points_to_award) -> void:
	emit_signal("destroyed", points_to_award)
	collision_shape.set_deferred("disabled", true)
	destroy_sfx.play()
	hide()
	yield(destroy_sfx, "finished")
	remove()


func hit(hitter: CollisionObject2D) -> void:
	match hitter.collision_layer:
		# Player
		1:
			destroy(0)
		# Any
		_:
			destroy(points)


func remove() -> void:
	queue_free()


# Signal handlers
func _on_VisibilityNotifier2D_screen_exited():
	remove()

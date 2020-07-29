extends RigidBody2D


signal destroyed(points)


onready var destroy_sfx: AudioStreamPlayer = $AudioPlayers/DestroySFX
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var sprite: Sprite = $Sprite

export (PackedScene) var explosion
export var points := 10


# Public API
func initialize(
	pos: Vector2,
	lin_velocity: Vector2,
	ang_velocity: float
) -> RigidBody2D:
	# Set object attributes
	position = pos
	linear_velocity = lin_velocity
	angular_velocity = ang_velocity
	return self


func destroy(points_to_award: int) -> void:
	# Hide sprite and disable collision
	collision_shape.set_deferred("disabled", true)
	sprite.visible = false

	# Spawn explosion effect and sound
	add_child(explosion.instance())
	destroy_sfx.play()

	emit_signal("destroyed", points_to_award)
	yield(destroy_sfx, "finished")
	# Cleanup
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

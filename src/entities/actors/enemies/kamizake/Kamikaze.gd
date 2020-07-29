extends KinematicBody2D


signal destroyed(points)


export (PackedScene) var explosion

onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var canvas: CanvasModulate = $Canvas
onready var destroy_sfx: AudioStreamPlayer = $AudioPlayers/DestroySFX

export var speed := 600
export var velocity := Vector2(0, 1)
export var points := 20


# Callbacks
func _physics_process(delta: float) -> void:
	var _coll = move_and_collide(velocity.normalized() * speed * delta, false)


# Public API
func destroy(points_to_award: int) -> void:
		# Hide sprite and disable collision
	collision_shape.set_deferred("disabled", true)
	canvas.visible = false

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

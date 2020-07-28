extends KinematicBody2D


signal destroyed(points)


export var speed := 600
export var velocity := Vector2(0, 1)
export var points := 20


# Callbacks
func _physics_process(delta: float) -> void:
	var _coll = move_and_collide(velocity.normalized() * speed * delta, false)


# Public API
func destroy(points_to_award: int) -> void:
	emit_signal("destroyed", points_to_award)
	queue_free()


func hit(hitter: CollisionObject2D) -> void:
	match hitter.collision_layer:
		# Player
		1:
			destroy(0)
		# Any
		_:
			destroy(points)

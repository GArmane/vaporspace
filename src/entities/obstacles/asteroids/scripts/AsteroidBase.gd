extends RigidBody2D


signal destroyed(points)


export var points := 10


# Public API
func destroy() -> void:
	emit_signal("destroyed", points)
	remove()


func hit(_hitter: Node) -> void:
	destroy()


func remove() -> void:
	queue_free()

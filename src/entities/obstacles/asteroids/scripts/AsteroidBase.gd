extends RigidBody2D


signal destroyed


# Public API
func destroy():
	emit_signal("destroyed")
	queue_free()


func hit(hitter: Node) -> void:
	destroy()

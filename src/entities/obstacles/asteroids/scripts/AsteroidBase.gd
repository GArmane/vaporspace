extends RigidBody2D


signal destroyed(points)


export var points := 10


# Public API
func destroy():
	emit_signal("destroyed", points)
	queue_free()


func hit(hitter: Node) -> void:
	destroy()

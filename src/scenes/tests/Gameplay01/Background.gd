extends ParallaxBackground


export var velocity := 150


func _process(delta: float) -> void:
	var offset = get_scroll_offset().y + velocity * delta
	set_scroll_offset(Vector2(0, offset))

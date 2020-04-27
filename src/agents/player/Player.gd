extends Area2D


export var speed := 400

onready var animated_sprite := $BodySprite
onready var bounding_box := get_viewport_rect().size


func _process_animation(velocity: Vector2):
	if velocity.length() > 0 and velocity.x != 0:
		animated_sprite.flip_h = velocity.x > 0
		animated_sprite.animation = "turn"
		animated_sprite.play()
	else:
		animated_sprite.animation = "idle"
		animated_sprite.stop()


func _process_movement(delta: float, velocity: Vector2):
	# Update position
	position += velocity * delta
	# Clamp position
	position.x = clamp(position.x, 0, bounding_box.x)
	position.y = clamp(position.y, 0, bounding_box.y)


func _process_velocity() -> Vector2:
	var velocity = Vector2()
	# Horizontal movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	# Vertical movement
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	# Normalize vector
	return velocity.normalized() * speed


func _process(delta: float):
	var velocity = _process_velocity()
	_process_movement(delta, velocity)
	_process_animation(velocity)

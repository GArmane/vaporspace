extends KinematicBody2D


export var speed := 400

onready var animated_sprite: AnimatedSprite = $BodySprite
onready var weapons_system: Node2D = $WeaponsSystem


# Callbacks
func _process(delta: float) -> void:
	_process_shooting()


func _physics_process(delta: float) -> void:
	var velocity = _process_velocity()
	_process_movement(delta, velocity)
	_process_animation(velocity)


# Private API
func _process_animation(velocity: Vector2) -> void:
	if velocity.length() > 0 and velocity.x != 0:
		animated_sprite.flip_h = velocity.x > 0
		animated_sprite.animation = "turn"
		animated_sprite.play()
	else:
		animated_sprite.animation = "idle"
		animated_sprite.stop()


func _process_collision(coll: KinematicCollision2D) -> void:
	var collider = coll.collider
	match collider.collision_layer:
		# Obstacles
		4:
			collider.hit(self)
			kill()
		# Any
		_:
			pass


func _process_movement(delta: float, velocity: Vector2) -> void:
	var coll = move_and_collide(velocity * delta, false)
	if coll:
		_process_collision(coll)


func _process_shooting() -> void:
	if Input.is_action_pressed("ui_select"):
		weapons_system.shoot_laser_beam()


func _process_velocity() -> Vector2:
	var velocity = Vector2()
	# Horizontal movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	# Normalize vector
	return velocity.normalized() * speed


# Public API
func kill():
	queue_free()

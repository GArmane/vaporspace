extends KinematicBody2D


onready var animated_sprite := $AnimatedSprite

export var speed := 0


func initialize(init_pos: Vector2, init_speed: int) -> KinematicBody2D:
	position = init_pos
	speed = init_speed
	return self


func calc_velocity(delta) -> Vector2:
	return Vector2(0, -speed) * delta


func _ready():
	animated_sprite.play()


func _physics_process(delta):
	var velocity = calc_velocity(delta)
	var _collision = move_and_collide(velocity)

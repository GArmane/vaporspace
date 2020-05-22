extends KinematicBody2D


onready var animated_sprite := $AnimatedSprite

export var speed := 0


func initialize(init_pos: Vector2, init_speed: int) -> KinematicBody2D:
	position = init_pos
	speed = init_speed
	return self


func _on_Visibility_screen_exited():
	queue_free()


func _physics_process(delta):
	var velocity = Vector2(0, -speed) * delta
	var _collision = move_and_collide(velocity)


func _ready():
	animated_sprite.play()

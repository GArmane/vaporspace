extends Area2D


onready var animated_sprite := $AnimatedSprite
export var speed := 750


func initialize(init_pos: Vector2, init_speed: int) -> Area2D:
	position = init_pos
	speed = init_speed
	return self


func _physics_process(delta):
	var velocity = Vector2(0, -speed) * delta
	position += velocity


func _ready():
	animated_sprite.play()


func _on_LaserBeam_body_entered(body: Node) -> void:
	body.hit(self)
	queue_free()

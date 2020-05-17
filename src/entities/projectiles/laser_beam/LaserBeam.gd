extends Area2D


onready var animated_sprite := $AnimatedSprite

export var speed := 10


func _ready():
	animated_sprite.play()


func _process(_delta):
	position.y += -speed

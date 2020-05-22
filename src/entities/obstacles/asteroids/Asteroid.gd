extends KinematicBody2D


onready var collision_shape := $CollisionShape2D
onready var rng := RandomNumberGenerator.new()
onready var sprite := $Sprite
onready var sprites = [
	{
		"texture": preload("res://src/entities/obstacles/asteroids/sprites/asteroid_01.png"),
		"collision": {
			"position": Vector2(0, 0),
			"radius": 19.5,
		},
	},
	{
		"texture": preload("res://src/entities/obstacles/asteroids/sprites/asteroid_02.png"),
		"collision": {
			"position": Vector2(-2, 4),
			"radius": 11.5
		},
	},
	{
		"texture": preload("res://src/entities/obstacles/asteroids/sprites/asteroid_03.png"),
		"collision": {
			"position": Vector2(-1, 2),
			"radius": 17.5,
		},
	},
	{
		"texture": preload("res://src/entities/obstacles/asteroids/sprites/asteroid_04.png"),
		"collision": {
			"position": Vector2(0, 2),
			"radius": 21.5,
		},
	},
]

export var speed := 0
export var velocity := Vector2(0, 0)


func switch_textures(index: int):
	# Set texture
	var new_sprite = sprites[index]
	sprite.set_texture(new_sprite["texture"])

	# Set collision shape
	var coll = new_sprite["collision"]
	collision_shape.position = coll["position"]
	var shape = collision_shape.get_shape()
	shape.set_radius(coll["radius"])


func _ready():
	rng.randomize()
	switch_textures(rng.randi_range(0, 3))

extends KinematicBody2D


onready var rng := RandomNumberGenerator.new()
onready var sprite := $Sprite
onready var textures = [
    preload("res://src/entities/obstacles/asteroids/sprites/asteroid_01.png"),
    preload("res://src/entities/obstacles/asteroids/sprites/asteroid_02.png"),
    preload("res://src/entities/obstacles/asteroids/sprites/asteroid_03.png"),
    preload("res://src/entities/obstacles/asteroids/sprites/asteroid_04.png"),
]

export var speed := 0
export var velocity := Vector2(0, 0)


func switch_textures():
    sprite.set_texture(textures[rng.randi_range(0, 3)])


func _ready():
    rng.randomize()
    switch_textures()

extends RigidBody2D


const sprites = [
	{
		"texture": preload("res://src/entities/obstacles/asteroid/sprites/asteroid_01.png"),
		"collision": {
			"position": Vector2(0, 0),
			"radius": 19.5,
		},
	},
	{
		"texture": preload("res://src/entities/obstacles/asteroid/sprites/asteroid_02.png"),
		"collision": {
			"position": Vector2(-2, 4),
			"radius": 11.5
		},
	},
	{
		"texture": preload("res://src/entities/obstacles/asteroid/sprites/asteroid_03.png"),
		"collision": {
			"position": Vector2(-1, 2),
			"radius": 17.5,
		},
	},
	{
		"texture": preload("res://src/entities/obstacles/asteroid/sprites/asteroid_04.png"),
		"collision": {
			"position": Vector2(0, 2),
			"radius": 21.5,
		},
	},
]


func switch_model(index: int):
	# Set texture
	var new_sprite = sprites[index]
	$Sprite.set_texture(new_sprite["texture"])

	# Set collision shape
	var coll = new_sprite["collision"]
	$CollisionShape2D.position = coll["position"]
	$CollisionShape2D.get_shape().set_radius(coll["radius"])

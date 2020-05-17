extends Node2D


export (PackedScene) var laser_beam
export var laser_speed := 0

onready var muzzle: Position2D = $Muzzle
onready var root := get_tree().get_root()


func shoot_laser_beam():
	var beam = laser_beam \
		.instance().initialize(muzzle.global_position, laser_speed)
	root.add_child(beam)

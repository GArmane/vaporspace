extends Node2D


export (PackedScene) var laser_beam
export var laser_speed := 0

onready var laser_ready_timer: Timer = $LaserReady
onready var muzzle: Position2D = $Muzzle
onready var root := get_tree().get_root()


func shoot_laser_beam():
	if laser_ready_timer.is_stopped():
		var beam = laser_beam \
			.instance().initialize(muzzle.global_position, laser_speed)
		root.add_child(beam)
		laser_ready_timer.start()

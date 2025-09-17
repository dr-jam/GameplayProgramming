class_name RotateAndLookAtCommand
extends CameraCommand

var _current_rotation:float = 0
var _rads_per_second:float = 0.5
var _height := Vector3(0.0, 7.0, 0.0)
var _rot_plane_distance := 3.0

func execute(camera:Camera3D, target:Node3D) -> bool:
	_current_rotation += _rads_per_second * Engine.get_main_loop().root.get_process_delta_time()
	var plane_offset := _rot_plane_distance * Vector3(sin(_current_rotation), 0.0, cos(_current_rotation))
	camera.global_position = target.global_position + _height + plane_offset
	camera.look_at(target.global_position)
	return true

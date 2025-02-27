extends Node3D
class_name Screen

@export var enabled = true :
	set(is_enabled):
		if is_enabled:
			$Screen/ScreenArea.call_deferred("set_process_mode", PROCESS_MODE_INHERIT)
		else:
			$Screen/ScreenArea.call_deferred("set_process_mode", PROCESS_MODE_DISABLED)

func _ready():
	$Screen/ScreenArea/Shape.shape.size.x = $Screen.mesh.size.x
	$Screen/ScreenArea/Shape.shape.size.y = $Screen.mesh.size.y
	$Screen.material_override.albedo_texture = $Viewport.get_texture()

func get_screen_position(global: Vector3):
	var local = $Screen.to_local(global) / $Screen/ScreenArea/Shape.shape.size
	var local_xy = (Vector2(local.x, local.y) + Vector2.ONE * 0.5)
	local_xy.y = 1 - local_xy.y
	return local_xy.clamp(Vector2.ZERO, Vector2.ONE) * Vector2($Viewport.size)

func dispatch_event(event: InputEvent):
	$Viewport.push_input(event)

extends SecurityState
class_name PursuingSecurityState

@export var move_speed := 60.0
@onready var ray_cast: RayCast2D = %RayCast2D
@onready var nav2d: NavigationAgent2D = %NavigationAgent2D

var pursued_player : PlayerController

#region Overrides
func start(cont : SecurityController):
	super.start(cont)
	nav2d.target_position = pursued_player.position

func phys_proc(_delta:float):
	_check_player_on_sight()
	_move_to_player()

func exit():
	pursued_player = null
	super.exit()
#endregion

#region Private functions
func _check_player_on_sight():
	ray_cast.target_position = to_local(pursued_player.position)
	ray_cast.force_raycast_update()
	if !ray_cast.is_colliding(): return
	var collider := ray_cast.get_collider()
	if collider is PlayerController:
		nav2d.target_position = pursued_player.position
	
func _move_to_player():
	var direction = (nav2d.get_next_path_position() - controller.position).normalized()
	controller.velocity = direction*move_speed
	controller.move_and_slide()
	if nav2d.is_target_reached() or !nav2d.is_target_reachable():
		controller.change_state(controller.lost_track_state)
#endregion

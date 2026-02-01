extends SecurityState
class_name PursuingSecurityState

@export var move_speed := 60.0
@onready var ray_cast: RayCast2D = %RayCast2D

var pursued_player : PlayerController

#region Overrides
func start(cont : SecurityController):
	super.start(cont)

func phys_proc(_delta:float):
	_move_to_player()
	_check_player_on_sight()

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
	if collider is PlayerController: return
	print(collider)
	controller.change_state(controller.patrol_state)
	
func _move_to_player():
	var direction = (pursued_player.position - controller.position).normalized()
	controller.velocity = direction*move_speed
	controller.move_and_slide()
#endregion

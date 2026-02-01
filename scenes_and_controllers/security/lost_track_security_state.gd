extends SecurityState
class_name LostTrackSecurityState

var wait_time := 4.0

#region Overrides
func start(cont : SecurityController):
	super.start(cont)
	_start_timer()

func phys_proc(_delta:float):
	pass

func exit():
	super.exit()
#endregion

#region Private functions
func _start_timer():
	var tween := create_tween()
	tween.tween_interval(wait_time)
	tween.tween_callback(func():
		controller.change_state(controller.going_back_state)
	)
#endregion

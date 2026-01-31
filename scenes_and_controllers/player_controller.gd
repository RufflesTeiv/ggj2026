extends CharacterBody2D
class_name PlayerController

#region Enums
#endregion

#region Parameters (consts and exportvars)
@export var max_speed_default := 100.0
@export var max_speed_running := 150.0
@export var acceleration := 50.0
@export var friction := 80.0
#endregion

#region Signals
#endregion

#region Variables
#endregion

#region Computed properties
#endregion

#region Default functions
#func _init(): pass
#func _enter_tree(): pass
#func _ready(): pass
#func _process(_delta): pass
func _physics_process(_delta):
	_move(_delta)
#func _input(_event: InputEvent): pass
#func _exit_tree(): pass
#endregion

#region Public functions
#endregion

#region Overridable functions
#endregion

#region Private functions
func _get_max_speed() -> float:
	if Input.is_action_pressed("run"):
		return max_speed_running
	return max_speed_default
	
func _move(delta:float):
	var input := Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()
	var lerp_weight := delta * (acceleration if input else friction)
	velocity = lerp(velocity, input*_get_max_speed(), lerp_weight)
	
	move_and_slide()
#endregion

#region Subclasses
#endregion

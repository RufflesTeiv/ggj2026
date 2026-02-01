extends CharacterBody2D
class_name SecurityController

#region Enums
enum State {
	LOOKING,
	PURSUING
}
#endregion

#region Parameters (consts and exportvars)
# States
@onready var lost_track_state: LostTrackSecurityState = %LostTrack
@onready var patrol_state: PatrolSecurityState = %Patrol
@onready var pursuing_state: SecurityState = %Pursuing
@onready var going_back_state: GoingBackSecurityState = %GoingBack
#endregion

#region Signals
#endregion

#region Variables
var current_state : SecurityState
var initial_position : Vector2
#endregion

#region Computed properties
#endregion

#region Default functions
#func _init(): pass
	
#func _enter_tree(): pass
	
func _ready():
	change_state(patrol_state)
	initial_position = global_position
	
#func _process(_delta): pass
	
func _physics_process(_delta):
	current_state.phys_proc(_delta)
	
#func _input(_event: InputEvent): pass

# unc _exit_tree(): pass
#endregion

#region Public functions
func change_state(new_state : SecurityState):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.start(self)
#endregion

#region Overridable functions
#endregion

#region Private functions
#endregion

#region Subclasses
#endregion

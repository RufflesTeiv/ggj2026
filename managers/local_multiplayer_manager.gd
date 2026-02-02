extends Node

#region Enums
#endregion

#region Parameters (consts and exportvars)
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
func _ready():
	_setup_multiplayer_inputs()
#func _process(_delta): pass
#func _physics_process(_delta): pass
#func _input(_event: InputEvent): pass
#func _exit_tree(): pass
#endregion

#region Public functions
#endregion

#region Overridable functions
#endregion

#region Private functions
func _setup_multiplayer_inputs():
	for action in InputMap.get_actions():
		if action.contains("ui_"): continue
		_setup_multi_action(action,4)
		
func _setup_multi_action(action:StringName, player_count:int):
	var events := InputMap.action_get_events(action)
	for event in events:
		if !(event is InputEventJoypadButton) and !(event is InputEventJoypadMotion):
			continue
		
	
#endregion

#region Subclasses
#endregion

extends Node2D
class_name SecurityState

#region Enums
#endregion

#region Parameters (consts and exportvars)
#endregion

#region Signals
#endregion

#region Variables
var controller : SecurityController
var exiting := false
#endregion

#region Computed properties
#endregion

#region Public functions
#endregion

#region Overridable functions
func start(cont : SecurityController):
	controller = cont
	
func phys_proc(_delta:float): pass

func exit():
	exiting = true
	controller = null
#endregion

#region Private functions
#endregion

#region Subclasses
#endregion
